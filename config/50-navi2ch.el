;;
;; navi2ch
;;
(use-package navi2ch
  :defer t
  ;; :commands navi2ch
  :config

  (setq browse-url-browser-function 'browse-url-generic)
  (setq browse-url-generic-program "open")

  (defun buffers-with-visited-file ()
    (delq nil
          (mapcar (lambda (buffer)
                    (if (buffer-file-name buffer)
                        buffer))
                  (buffer-list))))
  (defun boss-ga-kita ()
    (interactive)
    (delete-other-windows)
    (switch-to-buffer (or (car (buffers-with-visited-file))
                          (get-buffer-create "*scratch*"))))
  (define-key navi2ch-global-map [f8] 'boss-ga-kita)
  )
