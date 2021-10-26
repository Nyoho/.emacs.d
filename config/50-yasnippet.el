;;
;; yasnippet
;;
(leaf yasnippet
  :ensure t
  :custom
  (yas-key-syntaxes . '(yas-longest-key-from-whitespace "w_.()" "w_." "w_" "w"))
  :hook ((emacs-lisp-mode-hook . yas-minor-mode)
         (ruby-mode-hook . yas-minor-mode)
         (enh-ruby-mode-hook . yas-minor-mode)
         (web-mode-hook . yas-minor-mode)
         (css-mode-hook . yas-minor-mode)
         (tex-mode-hook . yas-minor-mode)
         (latex-mode-hook . yas-minor-mode)
         (text-mode-hook . yas-minor-mode)
         (js2-mode-hook . yas-minor-mode)
         (sgml-mode-hook . yas-minor-mode))
  :bind (:yas-minor-mode-map
         ("C-c C-v" . nil)
         ("M-i"     . yas-expand))
  ;; (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
  :config
  ;; (setq yas-snippet-dirs
  ;;       '("~/.emacs.d/snippets" ;; my snippets
  ;;         "~/.emacs.d/el-get/yasnippet/snippets" ;; default snippets
  ;;         ))
  (yas-reload-all))

(leaf consult-yasnippet
  :ensure t)

(defun my-get-boundary-and-thing ()
  "example of using `bounds-of-thing-at-point'"
  (interactive)
  (let (bounds pos1 pos2 mything)
    (setq bounds (bounds-of-thing-at-point 'symbol))
    (setq pos1 (car bounds))
    (setq pos2 (cdr bounds))
    (setq mything (buffer-substring-no-properties pos1 pos2))

    (message
     "thing begin at [%s], end at [%s], thing is [%s]"
     pos1 pos2 mything)))
;; (let (bounds)
;;   (setq bounds (bounds-of-thing-at-point 'symbol))
;;   (buffer-substring-no-properties (car bounds) (cdr bounds)))
;; (bounds-of-thing-at-point 'symbol)

