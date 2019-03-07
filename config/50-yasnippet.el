;;
;; yasnippet
;;
(use-package yasnippet
  :defer t
  :custom
  (yas-key-syntaxes '(yas-longest-key-from-whitespace "w_.()" "w_." "w_" "w"))
  :init
  ;; (setq yas-trigger-key "TAB")
  (add-hook 'emacs-lisp-mode-hook 'yas-minor-mode)
  (add-hook 'ruby-mode-hook 'yas-minor-mode)
  (add-hook 'enh-ruby-mode-hook 'yas-minor-mode)
  (add-hook 'web-mode-hook 'yas-minor-mode)
  (add-hook 'css-mode-hook 'yas-minor-mode)
  (add-hook 'tex-mode-hook 'yas-minor-mode)
  (add-hook 'latex-mode-hook 'yas-minor-mode)
  (add-hook 'text-mode-hook 'yas-minor-mode)
  (add-hook 'js2-mode-hook 'yas-minor-mode)
  (add-hook 'sgml-mode-hook 'yas-minor-mode)
  :config
  ;; (setq yas-snippet-dirs
  ;;       '("~/.emacs.d/snippets" ;; my snippets
  ;;         "~/.emacs.d/el-get/yasnippet/snippets" ;; default snippets
  ;;         ))

  ;; (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
  (define-key yas-minor-mode-map (kbd "C-c C-v") nil)
  (define-key yas-minor-mode-map (kbd "M-i") 'yas-expand)
  (yas-reload-all)
  ;; (yas-global-mode t)
  )

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


;; helm interface
;; http://d.hatena.ne.jp/syohex/20121207/1354885367
(eval-after-load "helm"
  '(progn
     (defun my-yas/prompt (prompt choices &optional display-fn)
       (let* ((names (loop for choice in choices
                           collect (or (and display-fn (funcall display-fn choice))
                                       choice)))
              (selected (helm-other-buffer
                         `(((name . ,(format "%s" prompt))
                            (candidates . names)
                            (action . (("Insert snippet" . (lambda (arg) arg))))))
                         "*helm yas/prompt*")))
         (if selected
             (let ((n (position selected names :test 'equal)))
               (nth n choices))
           (signal 'quit "user quit!"))))
     (custom-set-variables '(yas/prompt-functions '(my-yas/prompt)))))

;; snippet-mode for *.yasnippet files
(add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))
