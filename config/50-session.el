;;
;; session.el -- カーソル位置とか kill-ring とか覚えておいてくれて便利
;;
(use-package session
  :config
  (add-hook 'after-init-hook 'session-initialize)
  (setq session-save-print-spec '(t nil 40000))
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 65536))) ;; これがないと file-name-history に500個保存する前に max-string に達する
  (setq session-globals-max-string 100000)
  ;; デフォルトでは30
  (setq history-length 100000)
  (setq session-save-file "~/.session")
  (add-hook 'after-init-hook 'session-initialize))
