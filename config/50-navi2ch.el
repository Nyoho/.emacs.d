;; -*- lexical-binding: t; -*-
;;
;; navi2ch
;;
(leaf navi2ch
  :ensure nil
  :after t
  :bind ((navi2ch-global-map ([f8] . boss-ga-kita)))
  :setq ((browse-url-browser-function . 'browse-url-generic)
         (browse-url-generic-program . "open"))
  :config
  (require 'navi2ch)
  (require 'navi2ch-inline)

  (put 'navi2ch-ifxemacs 'lisp-indent-function 1)
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
                          (get-buffer-create "*scratch*")))))
