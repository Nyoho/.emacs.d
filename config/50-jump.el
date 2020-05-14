;;
;; jump 系
;;

;; ace-jump-mode よりjaunteのほういい気がする
;; (use-package jaunte)
;; (global-set-key (kbd "C-;") 'jaunte)
;; jaunte から avy に乗り換えてみた。2019年3月10日

(leaf avy
  :ensure t
  :bind (("C-;" . avy-goto-word-0)
         ("C-M-;" . avy-goto-line)))

;;
;; dumb-jump
;;
;; https://github.com/jacktasia/dumb-jump

(leaf dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :custom ((dumb-jump-selector . 'ivy)) ;; (dumb-jump-selector . helm)
  :config
  (dumb-jump-mode)
  :ensure t)
