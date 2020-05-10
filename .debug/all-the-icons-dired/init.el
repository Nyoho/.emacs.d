;; ~/.debug.emacs.d/all-the-icons-dired/init.el
;; you can run like 'emacs -q -l ~/.debug.emacs.d/{{pkg}}/init.el'
(when load-file-name
  (setq user-emacs-directory
        (expand-file-name (file-name-directory load-file-name))))
(prog1 "prepare leaf"
  (prog1 "package"
    (custom-set-variables
     '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                          ("melpa" . "https://melpa.org/packages/")
                          ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize))
  (prog1 "leaf"
    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf))))

(leaf all-the-icons-dired
  :ensure t
  :hook (dired-mode-hook . all-the-icons-dired-mode))
