;; you can run like 'emacs -q -l ~/.emacs.d/.debug/{{pkg}}/init.el'
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

(leaf vertico
  :ensure t
  :init
  (vertico-mode))

(leaf embark
  :ensure t
  :bind
  (("C-S-a" . embark-act)       ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  )

(leaf embark-consult
  :ensure t
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(leaf consult
  :ensure t
  :bind* (("M-m" . consult-recent-file))
  :bind (
         ("M-g ." . consult-ripgrep)))

(leaf marginalia
  :ensure t
  :init
  (marginalia-mode))

(leaf orderless
  :ensure t
  :init
  (icomplete-mode)
  :custom
  (completion-styles . '(orderless)))

(leaf affe
  :ensure t
  :after (orderless consult)
  :config
  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key
                     (kbd "M-.")))
