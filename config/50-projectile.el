(leaf projectile
  :ensure t
  ;; :setq ((projectile-completion-system . 'ivy))
  :bind
  (projectile-mode-map
   ("s-p"   . projectile-command-map)
   ("C-c p" . projectile-command-map))
  :init
  (projectile-mode))
