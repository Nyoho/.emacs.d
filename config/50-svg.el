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


(leaf svg-tag-mode
  :ensure t
  :require t
  :hook (;;(prog-mode-hook . svg-tag-mode)
         (org-mode-hook . svg-tag-mode))
  :config
  (setq svg-tag-tags
        '(
          ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))
          ("FIXME" . ((lambda (tag) (svg-tag-make "FIXME" :face 'org-todo :inverse t :margin 0))))
          ("\\/\\/\\W?MARK:\\|MARK:" . ((lambda (tag) (svg-tag-make "MARK" :face 'font-lock-doc-face :inverse t :margin 0 :crop-right t))))
          ("MARK:\\(.*\\)" . ((lambda (tag) (svg-tag-make tag :face 'font-lock-doc-face :crop-left t))))
          
          ("\\/\\/\\W?swiftlint:disable" . ((lambda (tag) (svg-tag-make "disabled lint rule:" :face 'org-done :inverse t :margin 0 :crop-right t))))
          ("swiftlint:disable\\(.*\\)" . ((lambda (tag) (svg-tag-make tag :face 'org-done :crop-left t))))
          
          ;; TODOS
          ("\\/\\/\\W?TODO\\|TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t :margin 0 :crop-right nil))))
          ;; ("TODO\\(.*\\)" . ((lambda (tag) (svg-tag-make tag :face 'org-todo :crop-left t))))

          ;; tag in org-mode
          ("\\s-\\(:[a-zA-Z]+:\\)$" . ((lambda (tag) (svg-tag-make tag :beg 1 :end -1))))
          ;; ("[[:space:]]+\\(:[a-zA-Z]+:\\)$" . ((lambda (tag) (svg-tag-make tag :beg 1 :end -1))))
          )))
