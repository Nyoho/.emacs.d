;;
;; markdown-mode
;;
(use-package markdown-mode
  :defer t
  :mode (("\\.text" . markdown-mode))
  :init
  (custom-set-faces
   '(markdown-header-face-2 ((t (:inherit org-level-2))))
   '(markdown-header-face-3 ((t (:inherit org-level-3))))
   '(markdown-header-face-4 ((t (:inherit org-level-4))))
   '(markdown-header-face-5 ((t (:inherit org-level-5))))
   '(markdown-header-face-6 ((t (:inherit org-level-6))))
   )

  :config
  (add-hook 'markdown-mode-hook '(lambda() (markdown-custom)))
;; brew install multimarkdown
(setq markdown-command "multimarkdown")
;; '(markdown-command "markdown_py" t)

  )

(defun markdown-custom ()
  "Remove M-n key bind."
  (interactive)
  ;; (setq markdown-command "markdown | smartypants")
  (local-unset-key (kbd "M-n")))



;; (setq markdown-preview-stylesheets (list (concat (getenv "HOME") "/Dropbox/Web/css/github.css")))
(setq markdown-preview-stylesheets (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css"))
;; (setq markdown-preview-stylesheets (list "http://thomasf.github.io/solarized-css/solarized-light.min.css"))

(setq markdown-preview-javascript '())
(add-to-list 'markdown-preview-javascript "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML")
;; (add-to-list 'markdown-preview-javascript '("http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML" . async))

(setq markdown-preview-custom-template (concat user-emacs-directory "/resources/markdown-preview-template.html"))

(setq markdown-command-needs-filename nil)


(add-hook 'markdown-mode-hook 'ac-emoji-setup)

;; markdown-preview-mode がすごく便利。なんと live reload 付き。
(use-package markdown-preview-mode :defer t)
