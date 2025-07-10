;; -*- lexical-binding: t; -*-
;;
;; popup -- Mac OS X の通常の view のように ctrl + command + d で辞書.app
;;
(leaf popup
  :ensure t)

(defun ns-popup-dictionary ()
  "カーソル付近の単語を Mac の辞書でひく"
  (interactive)
  (let ((word (substring-no-properties (thing-at-point 'word)))
        (old-buf (current-buffer))
        (dict-buf (get-buffer-create "*dictionary.app*"))
        (view-mode-p)
        (dict))
    (set-buffer dict-buf)
    (erase-buffer)
    (call-process "/Users/nyoho/src/commandline-dictionary-app/src/dict"
                  nil "*dictionary.app*" t word
                  "Japanese-English" "Japanese" "Japanese Synonyms")
    (setq dict (buffer-string))
    (set-buffer old-buf)
    (when view-mode
      (view-mode)
      (setq view-mode-p t))
    (popup-tip dict)
    (when view-mode-p
      (view-mode))))
;; (define-key global-map (kbd "C-M-d") 'ns-popup-dictionary)

;; http://sakito.jp/mac/dictionary.html
(defun dictionary ()
  "dictionary.app"
  (interactive)

  (let ((editable (not buffer-read-only))
        (pt (save-excursion (mouse-set-point last-nonmenu-event)))
        beg end)

    (if (and mark-active
             (<= (region-beginning) pt) (<= pt (region-end)) )
        (setq beg (region-beginning)
              end (region-end))
      (save-excursion
        (goto-char pt)
        (setq end (progn (forward-word) (point)))
        (setq beg (progn (backward-word) (point)))
        ))

    (browse-url
     (concat "dict:///"
             (url-hexify-string (buffer-substring-no-properties beg end))))))
(define-key global-map (kbd "C-c w") 'dictionary)

