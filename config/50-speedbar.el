;;
;; for speedbar
;;
;; ad-advised-definition-p が 24.4 からなくなったのでエラー
(use-package sr-speedbar
  :ensure nil
  :config
  (setq sr-speedbar-right-side nil) 

  :bind
  (("s-r" . sr-speedbar-toggle))
;; (global-set-key (kbd "s-s") 'sr-speedbar-toggle)
)
