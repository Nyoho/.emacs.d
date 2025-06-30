;; -*- lexical-binding: t; -*-
;;
;; markdown-mode
;;
(leaf markdown-mode
  :ensure t
  :commands markdown-mode
  :mode (("\\.text" . markdown-mode))
  :custom-face
  ((markdown-header-face-2 quote ((t (:inherit org-level-2))))
   (markdown-header-face-3 quote ((t (:inherit org-level-3))))
   (markdown-header-face-4 quote ((t (:inherit org-level-4))))
   (markdown-header-face-5 quote ((t (:inherit org-level-5))))
   (markdown-header-face-6 quote ((t (:inherit org-level-6)))))
  :hook (markdown-mode-hook . markdown-custom)
  :setq
  (markdown-command . "multimarkdown")
  ;; brew install multimarkdown
  ;; or "markdown_py"
  )

(defun markdown-custom ()
  "Remove M-n key bind."
  (interactive)
  ;; (setq markdown-command "markdown | smartypants")
  (local-unset-key (kbd "M-n")))



;; (setq markdown-preview-stylesheets (list (expand-file-name "~/Dropbox/Web/css/github.css")))
(setq markdown-preview-stylesheets (list "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.min.css"))
;; (setq markdown-preview-stylesheets (list "http://thomasf.github.io/solarized-css/solarized-light.min.css"))

(setq markdown-preview-javascript '())
(add-to-list 'markdown-preview-javascript "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML")
;; (add-to-list 'markdown-preview-javascript '("http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML" . async))

(setq markdown-preview-custom-template (concat user-emacs-directory "/resources/markdown-preview-template.html"))

(setq markdown-command-needs-filename nil)


;; (add-hook 'markdown-mode-hook 'ac-emoji-setup)

;; markdown-preview-mode がすごく便利。なんと live reload 付き。
(leaf markdown-preview-mode :ensure t)
