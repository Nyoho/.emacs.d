(leaf *svg-exp
  :if (window-system)
  :config
  ;; (image-type-available-p 'svg) => if 't' then ok
  (require 'svg)
  (defun sample-make-tag ()
  (let ((svg (svg-create 77 17)))
    ;; (svg-rectangle svg 3 0 71 17    :fill "blue")
    ;; (svg-circle    svg 3   3   3    :fill "blue")
    ;; (svg-rectangle svg 0   3   3 11 :fill "blue")
    ;; (svg-circle    svg 3  14   3    :fill "blue")
    ;; (svg-circle    svg 74  3   3    :fill "blue")
    ;; (svg-rectangle svg 74  3   3 11 :fill "blue")
    ;; (svg-circle    svg 74 14   3    :fill "blue")

    (svg-rectangle svg 3 0 71 17 :fill "blue" :rx 3 :ry 3)

    (svg-text svg "IMPORTANT"
              :font-family "Menlo" :font-weight "light"
              :font-size "12" :fill "white" :x 6 :y 13)
    (insert-image (svg-image svg :ascent 'center)))
    )
  )

