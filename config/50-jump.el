;;
;; jump 系
;;

;; ace-jump-mode よりjaunteのほういい気がする
;; (use-package jaunte)
;; (global-set-key (kbd "C-;") 'jaunte)
;; jaunte から avy に乗り換えてみた。2019年3月10日

(use-package avy
  :bind (("C-;" . avy-goto-word-0)))
