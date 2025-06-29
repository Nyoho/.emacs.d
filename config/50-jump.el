;; -*- lexical-binding: t; -*-
;;
;; jump 系
;;

;;
;; ace-jump-mode
;;
;; ヒント文字に使う文字を指定する
(setq ace-jump-mode-move-keys
      (append "asdfghjkl;:]qwertyuiop@zxcvbnm,." nil))
;; ace-jump-word-modeのとき文字を尋ねないようにする
(setq ace-jump-word-mode-use-query-char nil)

;; (global-set-key (kbd "C-;") 'ace-jump-char-mode)
;; (global-set-key (kbd "C-;") 'ace-jump-mode)
;; (global-set-key (kbd "C-;") 'ace-jump-word-mode)
;; (global-set-key (kbd "C-M-;") 'ace-jump-line-mode)


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
  :custom ((dumb-jump-selector . 'completing-read))
  :hook (xref-backend-functions . dumb-jump-xref-activate)
  :config
  (dumb-jump-mode)
  :ensure t)
