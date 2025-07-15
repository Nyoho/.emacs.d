;; -*- lexical-binding: t; -*-

(leaf projectile
  :ensure t
  :bind
  (projectile-mode-map
   ("s-p"   . projectile-command-map)
   ("C-c p" . projectile-command-map))
  :init
  (projectile-mode)
  :custom
  (projectile-switch-project-action . #'projectile-dired))
