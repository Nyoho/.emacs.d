(leaf typescript-mode
  :ensure t
  :mode 
  (("\\.ts\\'" . typescript-mode)
   ("\\.tsx\\'" . typescript-tsx-mode))
  :preface
  (define-derived-mode typescript-tsx-mode typescript-mode "TSX"
    (setq-local indent-line-function 'rjsx-indent-line))
  :bind 
  (typescript-tsx-mode-map
   ("<" . rjsx-electric-lt)
   (">" . rjsx-electric-gt))
  :custom
  (typescript-indent-level . 2)
  :setq 
  (typescript-tsx-indent-offset . 2)
  :hook
  (typescript-mode-hook . subword-mode)
  (typescript-tsx-mode-hook . rjsx-minor-mode)
  (typescript-tsx-mode-hook . tree-sitter-hl-mode)
  (typescript-tsx-mode-hook . (lambda ()
                                (rjsx-minor-mode)
                                (tree-sitter-hl-mode)))
  :config)

(leaf tide
  :ensure t
  :config
  (add-hook 'typescript-mode-hook
            (lambda ()
              (tide-setup)
              (flycheck-mode t)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode t)
              (company-mode-on))))
