(leaf posframe
  :ensure t
  :when window-system
  :config
  (leaf ivy-posframe
    :ensure t
    :when window-system
    :hook
    (ivy-mode . ivy-posframe-enable)
    :config
    (ivy-posframe-mode)
    :custom
    (ivy-display-function . #'ivy-posframe-display-at-frame-center)
    (ivy-posframe-parameters . '((left-fringe . 4)
                                 (right-fringe . 4)
                                 (internal-border-width . 8)
                                 (internal-border-color . "white")))
    ;; (ivy-posframe-display-functions-alist .
    ;;  '((swiper          . nil)
    ;;    (complete-symbol . ivy-posframe-display-at-point)
    ;;    ;; (counsel-M-x     . ivy-posframe-display-at-window-bottom-left)
    ;;    (counsel-M-x     . ivy-posframe-display-at-window-center)
    ;;    (t               . ivy-posframe-display)))
    :custom-face
    (ivy-posframe        . '((t (:background "#2B5B7A"))))
    (ivy-posframe-border . '((t (:background "#7272a4"))))
    (ivy-posframe-cursor . '((t (:background "#a0bfff"))))))

