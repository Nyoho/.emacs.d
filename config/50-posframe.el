(use-package ivy-posframe
  :custom
  (ivy-posframe-parameters '((left-fringe . 4) (right-fringe . 4)))
  :config
  (push '(counsel-M-x . ivy-posframe-display-at-point) ivy-display-functions-alist)
  (push '(complete-symbol . ivy-posframe-display-at-point) ivy-display-functions-alist)
  (push '(swiper . ivy-posframe-display-at-point) ivy-display-functions-alist)
  (ivy-posframe-enable))
