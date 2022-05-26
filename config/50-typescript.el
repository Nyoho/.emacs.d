(leaf typescript-mode
  :ensure t
  :mode 
  (("\\.ts\\'". typescript-mode)
   ;; ("\\.tsx\\'" . typescript-tsx-mode)
   )
  ;; :init
  ;; (define-derived-mode typescript-tsx-mode typescript-mode "TSX")
  :custom
  (typescript-indent-level . 2)
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
