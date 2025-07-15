;; -*- lexical-binding: t; -*-
;;
;; session.el -- カーソル位置とか kill-ring とか覚えておいてくれて便利
;;
(leaf session
  :ensure t
  :hook ((after-init-hook . session-initialize))
  :setq
  ((session-save-print-spec . '(t nil 40000))
   (session-initialize . '(de-saveplace session keys menus places))
   (session-globals-include . '((kill-ring 50)
				                (session-file-alist 500 t)
				                (file-name-history 65536)))
   (session-globals-max-string . 100000)
   (history-length . 100000)
   (session-save-file . "~/.session")
   (session-save-file-coding-system . 'utf-8)
   (session-name-disable-regexp . "/COMMIT_EDITMSG$")))
