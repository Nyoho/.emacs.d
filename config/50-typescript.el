;; -*- lexical-binding: t; -*-

(leaf typescript-mode
  :ensure t
  :mode 
  (("\\.ts\\'" . typescript-mode)
   ("\\.tsx\\'" . tsx-ts-mode))
  :custom
  (typescript-indent-level . 2)
  :setq 
  (typescript-tsx-indent-offset . 2)
  :hook
  (typescript-mode-hook . subword-mode)
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
