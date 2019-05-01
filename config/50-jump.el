;;
;; jump 系
;;

;; ace-jump-mode よりjaunteのほういい気がする
;; (use-package jaunte)
;; (global-set-key (kbd "C-;") 'jaunte)
;; jaunte から avy に乗り換えてみた。2019年3月10日

(use-package avy
  :bind (("C-;" . avy-goto-word-0)))

;;
;; dumb-jump
;;
;; https://github.com/jacktasia/dumb-jump

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :ensure)
