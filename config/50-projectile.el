(leaf projectile
  :ensure t
  :after t
  :setq ((projectile-completion-system . 'ivy))
  :config
  (projectile-global-mode))
