(use-package projectile
  :defer t
  :config
  (projectile-global-mode)
  (setq projectile-completion-system 'helm)
  (helm-projectile-on))

