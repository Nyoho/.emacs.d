
(leaf company
  :ensure t
  :init
  (global-company-mode +1)
  :custom
  (completion-ignore-case . t)
  (company-idle-delay . 0)
  (company-selection-wrap-around . t)
  (company-minimum-prefix-length . 2)
  :bind
  ((company-active-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous)
    ("C-s" . company-filter-candidates)
    ("C-i" . company-complete-selection)
    ("<tab>" . company-complete-selection))
   (company-search-map
    ("C-n" . company-select-next)
    ("C-p" . company-select-previous))
   (emacs-lisp-mode-map
    ("C-M-i" . company-complete)))
  :require t
  :config
  (leaf company-math
    :ensure t
    :after auctex org)

  ;; yasnippetとの連携
  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")
  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  )

(leaf company-box
  :ensure t
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  )
