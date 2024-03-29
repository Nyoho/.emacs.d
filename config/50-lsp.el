;; LSP - the Language Server Protocol

(leaf lsp-mode
  :ensure t
  :doc "s-l w s (=lsp)"
  :commands lsp lsp-rename
  :blackout lsp-mode
  :custom  (
            ;; debug
            (lsp-print-io . nil)
            (lsp-trace . nil)
            (lsp-print-performance . nil)
            ;; general
            (lsp-auto-guess-root . t)
            (lsp-document-sync-method . 'incremental) ;; always send incremental document
            (lsp-response-timeout . 5)
            (lsp-prefer-flymake . 'flymake)
            (lsp-enable-completion-at-point))
  :hook (;;(LaTeX-mode-hook  . lsp)
         ;; (ruby-mode-hook   . lsp)
         (rust-mode-hook   . lsp)
         (elixir-mode-hook . lsp)
         (go-mode-hook     . lsp))
  :bind
  (:lsp-mode-map ("C-c r"   . lsp-rename)
                 ("C-c C-c" . lsp-execute-code-action))
  :init
  (add-to-list 'exec-path (expand-file-name "~/ghq/github.com/elixir-lsp/elixir-ls/release"))
  (add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))
  :config
  ;; LSP UI tools

  (leaf lsp-ui
    :ensure t
    :commands lsp-ui-peek-find-references lsp-ui-peek-find-definitions lsp-ui-peek-find-implementation lsp-ui-imenu lsp-ui-sideline-mode ladicle/toggle-lsp-ui-doc lsp-ui-mode
    :custom ((lsp-ui-doc-enable . t)
             (lsp-ui-doc-header . t)
             (lsp-ui-doc-include-signature . t)
             (lsp-ui-doc-position . 'top) ;; top, bottom, or at-point
             (lsp-ui-doc-max-width . 150)
             (lsp-ui-doc-max-height . 30)
             (lsp-ui-doc-use-childframe . t)
             (lsp-ui-doc-use-webkit . t)
             ;; lsp-ui-flycheck
             (lsp-ui-flycheck-enable)
             ;; lsp-ui-sideline
             (lsp-ui-sideline-enable)
             (lsp-ui-sideline-ignore-duplicate . t)
             (lsp-ui-sideline-show-symbol . t)
             (lsp-ui-sideline-show-hover . t)
             (lsp-ui-sideline-show-diagnostics)
             (lsp-ui-sideline-show-code-actions)
             ;; lsp-ui-imenu
             (lsp-ui-imenu-enable)
             (lsp-ui-imenu-kind-position quote top)
             ;; lsp-ui-peek
             (lsp-ui-peek-enable . t)
             (lsp-ui-peek-peek-height . 20)
             (lsp-ui-peek-list-width . 50)
             (lsp-ui-peek-fontify quote on-demand)) ;; never, on-demand, or always
              

    :config
    (defun ladicle/toggle-lsp-ui-doc ()
      (interactive)
      (if lsp-ui-doc-mode
          (progn
            (lsp-ui-doc-mode -1)
            (lsp-ui-doc--hide-frame))
        (lsp-ui-doc-mode 1)))

    :bind
    (:lsp-mode-map
     ("C-c C-r" . lsp-ui-peek-find-references)
     ("C-c C-j" . lsp-ui-peek-find-definitions)
     ("C-c i"   . lsp-ui-peek-find-implementation)
     ("C-c m"   . lsp-ui-imenu)
     ("C-c s"   . lsp-ui-sideline-mode)
     ("C-c d"   . ladicle/toggle-lsp-ui-doc))

    :hook ((lsp-mode-hook . lsp-ui-mode)))
  )
  ;; Lsp completion

;; (use-package ccls
;;   :custom (ccls-executable "/usr/local/bin/ccls")
;;   :hook ((c-mode c++-mode objc-mode) .
;;          (lambda () (require 'ccls) (lsp))))

(leaf lsp-latex :ensure t)

(leaf lsp-julia
  :ensure t
  :custom
  (lsp-julia-default-environment . "~/.julia/environments/v1.7"))

(leaf lsp-tailwindcss
  :ensure t
  :url "https://github.com/merrickluo/lsp-tailwindcss"
  :doc "Use Tailwind CSS Language Server (@tailwindcss/language-server) internally.
npm install -g @tailwindcss/language-server"
  :custom
  (lsp-tailwindcss-add-on-mode . t)
  :config
  ;; (push 'tide-mode lsp-tailwindcss-major-modes)
  )
