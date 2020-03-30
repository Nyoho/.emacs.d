;; 検索置換が簡単になる
(use-package anzu
  :ensure t
  :init
  (global-anzu-mode +1)
  (setq anzu-use-migemo t)
  (setq anzu-search-threshold 1000)
  (setq anzu-minimum-input-length 3)
  :config

  :bind (("C-c r" . anzu-query-replace)
         ("C-c R" . anzu-query-replace-regexp)))

;; (global-set-key (kbd "C-c r") 'anzu-query-replace)
;; (global-set-key (kbd "C-c R") 'anzu-query-replace-regexp)
