;; -*- lexical-binding: t; -*-

;; 検索置換が簡単になる
(leaf anzu
  :ensure t
  :blackout t
  :init
  (global-anzu-mode +1)
  :custom
  (anzu-use-migemo . t)
  (anzu-search-threshold . 1000)
  (anzu-minimum-input-length . 3)
  :bind (("C-c r" . anzu-query-replace)
         ("C-c R" . anzu-query-replace-regexp)))
