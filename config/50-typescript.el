(leaf typescript-mode
  :ensure t
  :mode ("\\.ts\\'")
  :config)

(use-package tide
  :defer t
  :config
  (add-hook 'typescript-mode-hook
            (lambda ()
              (tide-setup)
              (flycheck-mode t)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode t)
              (company-mode-on))))
