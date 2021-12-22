
(defun consult-ripgrep-org ()
  "`~/org/' 以下を検索 with consult."
  (interactive)
  (consult-ripgrep "~/org/" ""))

(defun affe-grep-org ()
  "`~/org/' 以下を検索 with affe."
  (interactive)
  (affe-grep "~/org/" ""))

(leaf visual-regexp
  :ensure t
  :bind (("M-%" . vr/query-replace)))

(leaf prescient
  :ensure t
  :custom
  `((prescient-aggressive-file-save . t)
    (prescient-save-file . ,(expand-file-name "~/.emacs.d/prescient-save.el")))
  :global-minor-mode prescient-persist-mode)

(leaf rg
  :ensure t)

(leaf avy
  :url "https://www.yewton.net/2020/05/31/avy-migemo/"
  :bind (("C-M-'" . avy-goto-migemo-timer))
  :after migemo
  :config
  (defun avy-goto-migemo-timer (&optional arg)
    (interactive "P")
    (let ((avy-all-windows (if arg
                               (not avy-all-windows)
                             avy-all-windows)))
      (avy-with avy-goto-migemo-timer
        (setq avy--old-cands (avy--read-candidates #'migemo-get-pattern))
        (avy-process avy--old-cands))))
  (add-to-list 'avy-styles-alist
               '(avy-goto-migemo-timer . pre)))


(leaf vertico
  :ensure t
  :init
  (vertico-mode))

(leaf embark
  :ensure t
  :bind
  (("s-e" . embark-act)
   ("C-h B" . embark-bindings))
  :config
  (setq prefix-help-command #'embark-prefix-help-command)
  (setq embark-action-indicator
        (lambda (map _target)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator))

(leaf embark-consult
  :ensure t
  :require t
  :after embark consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(leaf consult
  :ensure t
  :bind* (("M-m" . consult-buffer)
          ("M-g ," . consult-grep)
          ("M-g ." . consult-ripgrep)
          ("C-c o" . consult-outline)
          ("C-x C-a" . my-consult-project))
  :bind (("M-s" . consult-line)
         ("C-M-s" . consult-line))
  :config
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-root-function #'projectile-project-root)

  (setq my-consult--source-project-buffer
        (plist-put consult--source-project-buffer :hidden nil))

  (setq my-consult--source-project-file
        (plist-put consult--source-project-file :hidden nil))

  (defun my-consult-project ()
    "my `consult' command for project only"
    (interactive)
    (when-let (buffer (consult--multi '(my-consult--source-project-buffer
                                        my-consult--source-project-file)
                                      :require-match
                                      t ;(confirm-nonexistent-file-or-buffer)
                                      :prompt "(in proj) Switch to: "
                                      :history nil
                                      :sort nil))
      (unless (cdr buffer)
        (consult--buffer-action (car buffer))))))

(leaf orderless
  :require t
  :ensure t
  :init
  (icomplete-mode)
  (defun orderless-migemo (component)
    (let ((pattern (migemo-get-pattern component)))
      (condition-case nil
          (progn (string-match-p pattern "") pattern)
        (invalid-regexp nil))))

  :config
  (orderless-define-completion-style orderless-default-style
    (orderless-matching-styles '(orderless-literal
                                 orderless-regexp)))

  (orderless-define-completion-style orderless-migemo-style
    (orderless-matching-styles '(orderless-literal
                                 orderless-regexp
                                 orderless-migemo)))

  (orderless-define-completion-style orderless-strict-full-initialism-style
    (orderless-matching-styles '(orderless-strict-full-initialism)))

  (setq completion-category-overrides
        '((command (styles orderless-strict-full-initialism-style))
          (file (styles orderless-migemo-style))
          (buffer (styles orderless-migemo-style))
          (symbol (styles orderless-default-style))
          (consult-location (styles orderless-migemo-style)) ; category `consult-location' は `consult-line' などに使われる
          (consult-multi (styles orderless-migemo-style)) ; category `consult-multi' は `consult-buffer' などに使われる
          (org-roam-node (styles orderless-migemo-style)) ; category `org-roam-node' は `org-roam-node-find' で使われる (Thx: naoking158)
          (unicode-name (styles orderless-migemo-style))
          (variable (styles orderless-default-style))))

  ;; (setq orderless-matching-styles '(orderless-literal orderless-regexp orderless-migemo))

  :custom
  (completion-styles . '(orderless)))

(leaf marginalia
  :ensure t
  :init
  (marginalia-mode)
  :config
  (add-to-list 'marginalia-prompt-categories '("\\<Heading\\>" . file))
  (add-to-list 'marginalia-prompt-categories '("\\<Node\\>" . file))
  (add-to-list 'marginalia-prompt-categories
               '("\\<Fuzzy grep in.*\\>" . file)))

(leaf affe
  :ensure t
  :after orderless consult
  :bind
  ;; (("M-g ." . affe-grep))
  :custom
  (affe-find-command . "fd -HI -t f")
  :config
  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key
                     (kbd "M-.")))

(leaf ghq
  :ensure t)
  
(leaf consult-ghq
  :ensure t
  :after ghq)
