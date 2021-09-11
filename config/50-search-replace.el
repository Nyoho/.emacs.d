;; ivy, counsel
;; Thanks, abo-abo. https://github.com/abo-abo/swiper/

(leaf counsel
  :disabled t
  :ensure t
  :diminish ivy-mode counsel-mode
  ;; :bind* (("M-m" . counsel-buffer-or-recentf))
  ;; :bind (("C-x b" . counsel-switch-buffer)
  ;;        ("M-g ." . counsel-rg))
  )

(leaf ivy
  :disabled t
  :ensure t
  :custom
  (ivy-use-virtual-buffers . t)
  (ivy-pre-prompt-function . #'my-pre-prompt-function)
  :config
  (ivy-mode 1)
  (defun my-pre-prompt-function ()
    (if window-system
        (format "%s\n%s "
                (make-string (frame-width) ?\x5F) ;; "__"
                (all-the-icons-faicon "sort-amount-asc")) ;; ""
      (format "%s\n" (make-string (1- (frame-width)) ?\x2D))))

  (leaf ivy-migemo
    :ensure t
    :url "https://github.com/ROCKTAKEY/ivy-migemo")

  (leaf *ivy-format-functions
    :when window-system
    :config
    (defun my-ivy-format-function-arrow (cands)
        "Transform CANDS into a string for minibuffer."
        (ivy--format-function-generic
         (lambda (str)
           (concat (all-the-icons-faicon
                    "hand-o-right"
                    :v-adjust -0.2 :face 'my-ivy-arrow-visible)
                   " " (ivy--add-face str 'ivy-current-match)))
         (lambda (str)
           (concat (all-the-icons-faicon
                    "hand-o-right" :face 'my-ivy-arrow-invisible) " " str))
         cands
         "\n"))
      (setq ivy-format-functions-alist
            '((t . my-ivy-format-function-arrow))))
    
  (defface my-ivy-arrow-visible
    '((((class color) (background light)) :foreground "orange")
      (((class color) (background dark)) :foreground "#EE63EE"))
    "Face used by Ivy for highlighting the arrow.")

  (defface my-ivy-arrow-invisible
    '((((class color) (background light)) :foreground "#FFFFFF")
      (((class color) (background dark)) :foreground "#31343F"))
    "Face used by Ivy for highlighting the invisible arrow.")

  (leaf ivy-hydra :ensure t)
  (leaf all-the-icons-ivy
    :ensure t
    :custom
    (all-the-icons-ivy-buffer-commands . '(ivy-switch-buffer ivy-switch-buffer-other-window counsel-projectile-switch-to-buffer counsel-buffer-or-recentf))
    :config
    (all-the-icons-ivy-setup))

  (leaf all-the-icons-ivy-rich
    :ensure t
    :when window-system
    :init (all-the-icons-ivy-rich-mode 1))

  (leaf ivy-rich
    :ensure t
    :when window-system
    :init (ivy-rich-mode 1))
  )

(leaf swiper
  :disabled t
  :ensure t
  :after dash s
  :commands swiper swiper-all
  :bind (("M-s" . swiper)
         ("C-M-s" . swiper-all-thing-at-point))
  :custom ((ivy-re-builders-alist . '((t . ivy--regex-plus)
                                      (counsel-rg . ytn-ivy-migemo-re-builder)
                                      (swiper . ytn-ivy-migemo-re-builder)
                                      (org-recent-headings . ytn-ivy-migemo-re-builder)
                                      (org-roam-find-file . ivy-migemo--regex-plus)
                                      )))
  :config
  (defun ad:swiper-all-thing-at-point ()
    "`swiper-all' with `ivy-thing-at-point'."
    (interactive)
    (let ((thing (if (thing-at-point-looking-at "^\\*+")
                     nil
                   (ivy-thing-at-point))))
      (when (use-region-p)
        (deactivate-mark))
      (swiper-all thing)))

  ;; https://www.yewton.net/2020/05/21/migemo-ivy/
  (defun ytn-ivy-migemo-re-builder (str)
    (let* ((sep " \\|\\^\\|\\.\\|\\*")
           (splitted (--map (s-join "" it)
                            (--partition-by (s-matches-p " \\|\\^\\|\\.\\|\\*" it)
                                            (s-split "" str t)))))
      (s-join "" (--map (cond ((s-equals? it " ") ".*?")
                              ((s-matches? sep it) it)
                              (t (migemo-get-pattern it)))
                        splitted))))
  :advice ((:override swiper-all-thing-at-point ad:swiper-all-thing-at-point)))


(defun counsel-rg-org ()
  "`~/org/' 以下を検索 with counsel."
  (interactive)
  (counsel-rg "" "~/org/"))

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

(leaf smex
  :doc "コマンドの使用履歴を保存してcounselなどで優先してくれる"
  :ensure t
  :setq ((smex-history-length . 50)
         (smex-completion-method . 'ivy)))

(leaf prescient
  :ensure t
  :custom
  `((prescient-aggressive-file-save . t)
    (prescient-save-file . ,(expand-file-name "~/.emacs.d/prescient-save.el")))
  :global-minor-mode prescient-persist-mode)

(leaf ivy-prescient
  :disabled t
  :ensure t
  :config
  (ivy-prescient-mode 0))

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
  :bind (("M-s" . consult-line))
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
  :ensure t
  :init
  (icomplete-mode)
  (defun orderless-migemo (component)
    (let ((pattern (migemo-get-pattern component)))
      (condition-case nil
          (progn (string-match-p pattern "") pattern)
        (invalid-regexp nil))))

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
