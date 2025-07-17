;;  -*- lexical-binding: t; -*-
;; Set faces
;;

(defvar after-load-theme-hook nil
  "Hooks run after a color theme is loaded using `load-theme'.")

(defun run-after-load-theme-hook (&rest _)
  (run-hooks 'after-load-theme-hook))

(advice-add 'enable-theme :after #'run-after-load-theme-hook)

(defun set-my-mode-line ()
  (set-face-attribute 'mode-line nil
                      :family "DIN Condensed"
                      :weight 'bold
                      :height 1.0
                      :foreground "white"
                      :background "MediumPurple2")
  
  (set-face-attribute 'mode-line-inactive nil
                      :family "DIN Condensed"
                      :weight 'bold
                      :height 1.0
                      :foreground "gray70"
                      :background "gray20")

  (setq-default mode-line-format
                (cons (propertize "\u200b" 'display '((raise 0.5) (height 0.0))) mode-line-format))

  (set-face-background 'region "DeepPink"))

(leaf *modeline-customization*
  :when window-system
  :hook
  (after-load-theme-hook . set-my-mode-line)
  (after-init-hook . set-my-mode-line)
  :config
  (set-my-mode-line))
