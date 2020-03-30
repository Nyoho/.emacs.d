;; themes
(leaf themes
  :when window-system
  :ensure (anti-zenburn-theme
           solarized-theme
           moe-theme
           monokai-theme
           zenburn-theme
           reverse-theme
           waher-theme
           heroku-theme
           abyss-theme
           ahungry-theme
           blackboard-theme
           anti-zenburn-theme
           hc-zenburn-theme
           apropospriate-theme
           rebecca-theme
           railscasts-theme
           railscasts-reloaded-theme
           reykjavik-theme
           seoul256-theme)
  :config
  (load-theme 'hc-zenburn t)
  ;; Themes
  ;;
  ;; To reset the currently applied theme, evaluate the following line.
  ;; (mapc 'disable-theme custom-enabled-themes)

  ;; (load-theme 'heroku t)
  ;; (load-theme 'rebecca t)
  ;; (load-theme 'apropospriate-dark t)
  ;; (load-theme 'anti-zenburn t)
  ;; (load-theme 'leuven t)

  ;; (load-theme 'sanityinc-solarized-light t)
  ;; (load-theme 'sanityinc-solarized-dark t)
  ;; (load-theme 'solarized-dark t)

  ;; (load-theme 'whiteboard t)
  ;; (load-theme 'blackboard t)

  ;; (color-theme-initialize)
  ;; (color-theme-solarized-light)
  ;; (color-theme-github)
  ;; (color-theme-monokai)
  ;; (color-theme-solarized)
  ;; (color-theme-solarized-dark)
  ;; (color-theme-select)
  )
