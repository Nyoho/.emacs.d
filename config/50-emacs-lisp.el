(leaf emacs-lisp
  :hook (emacs-lisp-mode . smartparens-mode))

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

(leaf scratch-comment
  :ensure t
  :bind ((lisp-interaction-mode-map
          :package elisp-mode
          ("C-c C-j" . scratch-comment-eval-sexp))))

(leaf lispy :ensure t)

(leaf parinfer-rust-mode
  :ensure t
  :hook emacs-lisp-mode)
