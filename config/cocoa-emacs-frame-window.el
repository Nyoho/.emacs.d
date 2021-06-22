;;
;; Appearance settings for Cocoa Emacs ns NEXTSTEP
;;

(when window-system
  ;; (setq default-input-method "MacOSX")
  ;; (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)

  ;; 色など

  ;; (setq default-frame-alist
  ;;       (append '(
  ;;                 ;; (foreground-color . "black" )
  ;;                 ;; (foreground-color . "white" )                      
  ;;                 (foreground-color . "#dddddd" )
  ;;                 ;;(foreground-color . "#cccccc" )
  ;;                 ;; (background-color . "white" )
  ;;                 ;; (background-color . "#fefeff" )
  ;;                 ;; (background-color . "#283030" ) ;; dark green terminal
  ;;                 ;; (background-color . "#222222" )
  ;;                 (background-color . "#162020" ) ;; dark green terminal

  ;;                 ;; (background-color . "black" )
  ;;                 ;; (alpha . (93 83))
  ;;                 (alpha . (100 83))
  ;;                 ;; (background-color . "#f8f8f8" )
  ;;                 (border-color . "red" )
  
  ;;                 (width . 100)
  ;;                 (height . 55)
  ;;                 (top . 0)
  ;;                 (left . 590)
  ;;                 (cursor-color . "orange" )

  ;;                 ;; (cursor-color . "dark slate blue" )
  ;;                 ;; (cursor-type . bar) ;;box
  ;;                 (cursor-type . box)
  ;;                 (cursor-height . 4)
  ;;                 (mouse-color . "dark slate blue" )
  ;;                 )
  ;;               default-frame-alist))


  ;; (setq default-frame-alist
  ;;       (append '(
  ;;                 (width . 100)
  ;;                 (height . 55)
  ;;                 (top . 0)
  ;;                 (left . 590)

  ;;                 (cursor-type . box)
  ;;                 (cursor-height . 4)
  ;;                 (mouse-color . "dark slate blue" )
  ;;                 )
  ;;               default-frame-alist))

  (when (memq window-system '(mac ns))
    (setq initial-frame-alist
          (append
           '((ns-transparent-titlebar . t)
             (vertical-scroll-bars . nil)
             (ns-appearance . dark) ;; 26.1 {light, dark}
             ;; (ns-appearance . light) ;; 26.1 {light, dark}
             (internal-border-width . 0)

             (width . 90)
             (height . 50)
             (top . 44)
             (left . 800)
             (alpha . (100 100))
             
             (cursor-type . box)
             (cursor-height . 4)
             ;; (mouse-color . "dark slate blue" )
             (mouse-color . "light slate blue")
             (cursor-color . "orange red")
             ))))

  (setq default-frame-alist initial-frame-alist)


  (setq dnd-open-file-other-window nil)

  (setq
   ;; ホイールでスクロールする行数を設定
   mouse-wheel-scroll-amount '(1 ((shift) . 2) ((control)))
   ;; 速度を無視する
   mouse-wheel-progressive-speed nil)
  (setq scroll-preserve-screen-position 'always)
  
  )
