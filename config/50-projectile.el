(leaf projectile
  :ensure t
  :require t
  :setq ((projectile-completion-system . 'ivy))
  :bind
  (projectile-mode-map
   ("s-p"   . projectile-command-map)
   ("C-c p" . projectile-command-map))
  :config
  (leaf counsel-projectile
    :ensure t
    :bind
    ("M-o p" . counsel-projectile-switch-project))
  (projectile-mode))
