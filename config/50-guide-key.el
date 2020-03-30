(use-package guide-key
  :ensure t
  :config

  (setq guide-key/guide-key-sequence
        '("C-x r" "C-x 4" ; global
          (org-mode "C-c C-x")
          (outline-minor-mode "C-c @")))

  (setq guide-key/highlight-command-regexp "rectangle\\|register\\|org-clock")
  (setq guide-key/idle-delay 1.0)
  ;; ;; 下部にキー一覧を表示させる(デフォルトはright)
  ;; (setq guide-key/popup-window-position 'bottom)
  (setq guide-key/text-scale-amount -1)
  (guide-key-mode 1))

;; which-key も入れてみた。-> けど外してみた
;; (use-package which-key
;;   :diminish which-key-mode
;;   :init
;;   (which-key-setup-side-window-right-bottom) ;; 画面幅によって右端または下部に表示
;;   (which-key-mode t))
