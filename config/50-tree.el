;;
;; https://www.emacswiki.org/emacs/NeoTree

(leaf neotree
  :ensure t
  :commands neotree-toggle
  :bind (([f8] . neotree-toggle))
  :config
  (setq neo-show-hidden-files nil)
  ;; (setq neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$"))
 
  ;; all-the-icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  (setq neo-create-file-auto-open t)
  (setq neo-persist-show t)
  (setq neo-keymap-style 'concise)
  (setq neo-smart-open t))

(leaf treemacs
  :ensure t
  :bind (("M-0" . treemacs-select-window)
         ("C-x t 1" . treemacs-delete-other-windows)
         ("C-x t t" . treemacs)
         ("C-x t B" . treemacs-bookmark)
         ("C-x t C-t" . treemacs-find-file)
         ("C-x t M-t" . treemacs-find-tag))
  :config
  (with-eval-after-load 'winum
    (define-key winum-keymap
      (kbd "M-0")
      #'treemacs-select-window))

  (with-eval-after-load 'treemacs
    (progn
      (setq treemacs-collapse-dirs (if treemacs-python-executable
                                       3 0)
            treemacs-deferred-git-apply-delay 0.5
            treemacs-directory-name-transformer #'identity
            treemacs-display-in-side-window t
            treemacs-eldoc-display t
            treemacs-file-event-delay 5000
            treemacs-file-extension-regex treemacs-last-period-regex-value
            treemacs-file-follow-delay 0.2
            treemacs-file-name-transformer #'identity
            treemacs-follow-after-init t
            treemacs-git-command-pipe ""
            treemacs-goto-tag-strategy 'refetch-index
            treemacs-indentation 2
            treemacs-indentation-string " "
            treemacs-is-never-other-window nil
            treemacs-max-git-entries 5000
            treemacs-missing-project-action 'ask
            treemacs-move-forward-on-expand nil
            treemacs-no-png-images nil
            treemacs-no-delete-other-windows t
            treemacs-project-follow-cleanup nil
            treemacs-persist-file (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
            treemacs-position 'left
            treemacs-recenter-distance 0.1
            treemacs-recenter-after-file-follow nil
            treemacs-recenter-after-tag-follow nil
            treemacs-recenter-after-project-jump 'always
            treemacs-recenter-after-project-expand 'on-distance
            treemacs-show-cursor nil
            treemacs-show-hidden-files t
            treemacs-silent-filewatch nil
            treemacs-silent-refresh nil
            treemacs-sorting 'alphabetic-asc
            treemacs-space-between-root-nodes t
            treemacs-tag-follow-cleanup t
            treemacs-tag-follow-delay 1.5
            treemacs-user-mode-line-format nil
            treemacs-user-header-line-format nil
            treemacs-width 35)
      (treemacs-follow-mode t)
      (treemacs-filewatch-mode t)
      (treemacs-fringe-indicator-mode t)
      (pcase (cons
              (not (null (executable-find "git")))
              (not (null treemacs-python-executable)))
        (`(t . t)
         (treemacs-git-mode 'deferred))
        (`(t . _)
         (treemacs-git-mode 'simple))))))


(leaf treemacs-evil
  :after treemacs evil
  :ensure t)

(leaf treemacs-projectile
  :after treemacs projectile
  :ensure t)

(leaf treemacs-icons-dired
  :after treemacs dired
  :ensure t
  ;; :config (treemacs-icons-dired-mode)
  :hook (dired-mode-hook . (lambda ()
                             (treemacs-icons-dired-mode))))

(leaf treemacs-magit
  :after treemacs magit
  :ensure t)

(leaf treemacs-persp
  :after treemacs persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))
