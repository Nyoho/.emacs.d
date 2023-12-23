;;
;; for speedbar
;;
;; ad-advised-definition-p が 24.4 からなくなったのでエラー
(leaf sr-speedbar
  :ensure t
  :config
  (setq sr-speedbar-right-side nil) 

  :bind
  (("s-r" . sr-speedbar-toggle)))
