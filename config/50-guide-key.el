;; which-key も入れてみた。-> けど外してみた -> また有効にした。
(leaf which-key
  :ensure t
  :blackout which-key-mode
  :init
  (which-key-setup-side-window-right-bottom) ;; 画面幅によって右端または下部に表示
  (which-key-mode t))
