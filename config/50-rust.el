;; From http://keens.github.io/blog/2016/12/29/kizuitararustnokankyoukouchikugakanarirakuninatteta/
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin/"))
(eval-after-load "rust-mode"
  '(setq-default rust-format-on-save t))
(add-hook 'rust-mode-hook (lambda ()
                            (racer-mode)
                            (flycheck-rust-setup)))
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook (lambda ()
                             (company-mode)
                             (set (make-variable-buffer-local 'company-idle-delay) 0.3)
                             (set (make-variable-buffer-local 'company-minimum-prefix-length) 1)))

;; rustup component add rust-src しておく
;; rustup default nightly

(defun add-hook-rust-test ()
  (interactive)
  (add-hook 'after-save-hook (lambda ()
                               (rust-test))))
(defun run-rust-test ()
  (interactive)
  (rust-test))

(use-package rust
  :bind (("C-c C-c" . run-rust-test)))

;;   :hook ((c-mode c++-mode objc-mode) .
;;          (lambda () (require 'ccls) (lsp))))

