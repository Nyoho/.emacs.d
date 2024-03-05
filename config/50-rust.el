;; From http://keens.github.io/blog/2016/12/29/kizuitararustnokankyoukouchikugakanarirakuninatteta/
;; rustup component add rust-src しておく
;; rustup default nightly

(leaf rust-mode
  :ensure t
  :hook ((flycheck-mode-hook . flycheck-rust-setup)
         (rust-mode-hook . (lambda ()
                             (flycheck-rust-setup)))
         ;; (racer-mode-hook . eldoc-mode)
         ;; (racer-mode-hook . (lambda ()
         ;;                      (company-mode)
         ;;                      (set (make-variable-buffer-local 'company-idle-delay)  0.3)
         ;;                      (set (make-variable-buffer-local 'company-minimum-prefix-length) 1)))
         )
  :custom ((rust-format-on-save . t))
  :config
  (add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

  (defun add-hook-rust-test nil
    (interactive)
    (add-hook 'after-save-hook
              (lambda nil
                (rust-test))))

  (defun run-rust-test nil
    (interactive)
    (rust-test))

  (leaf racer :ensure t)
  ;; cargo +nightly install racer

  (leaf flycheck-rust
    :ensure t
    :after flycheck rust)

  :bind (rust-mode-map ("C-c C-c" . run-rust-test)))

;;   :hook ((c-mode c++-mode objc-mode) .
;;          (lambda () (require 'ccls) (lsp))))

(leaf rustic
  :ensure t
  :after rust-mode)
