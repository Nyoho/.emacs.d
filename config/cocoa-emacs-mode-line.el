;;
;; Set faces
;;

(leaf modeline-customization
  :when window-system
  :config
  ;; '(ns-marked-text-face ((t (:background "DeepPink4" :underline t))))
  ;; '(ns-working-text-face ((((background dark)) (:underline "gray80"))))
  
  ;; (set-face-attribute 'mode-line nil :family "Optima" :height 0.95)
  (set-face-attribute 'mode-line nil :family "DIN Condensed" :height 1.0)
  (set-face-attribute 'mode-line-inactive nil :family "DIN Condensed" :height 1.0)
  
  (setq-default mode-line-format
                (cons (propertize "\u200b" 'display '((raise 0.5) (height 0.0))) mode-line-format))

  ;; '(mode-line-inactive ((t (:background "#262626" :foreground "#888" :box nil :height 1.1 :family "Optima"))))

  ;; '(mode-line ((t (:background "#32649c" :foreground "white" :box nil :height 1.1 :width condensed :family "Optima"))))
  ;; '(mode-line-inactive ((t (:background "#262626" :foreground "#888" :box nil :height 1.1 :family "Optima"))))

  ;; (set-face-foreground 'mode-line "white")
  ;; (set-face-foreground 'mode-line "black")
  ;; (set-face-background 'mode-line "MediumPurple2")
  ;; (set-face-background 'mode-line-highlight "MediumPurple2")
  ;; (set-face-background 'region "LightSteelBlue2")
  (set-face-background 'region "DeepPink")
  (set-face-foreground 'mode-line-inactive "gray11")
  (set-face-background 'mode-line-inactive "gray20")
  )
