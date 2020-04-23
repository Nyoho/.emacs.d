
(leaf company
  :ensure t
  :init
  (global-company-mode +1)
  :custom
  (completion-ignore-case . t)
  (company-idle-delay . 0)
  (company-selection-wrap-around . t)
  :bind
  ((company-active-map ("C-n" . company-select-next))
   (company-active-map ("C-p" . company-select-previous))
   (company-search-map ("C-n" . company-select-next))
   (company-search-map ("C-p" . company-select-previous))
   (company-active-map ("C-s" . company-filter-candidates))
   (company-active-map ("C-i" . company-complete-selection))
   (emacs-lisp-mode-map ("C-M-i" . company-complete)))
  :require t
  :config
  (leaf company-auctex
    :ensure t
    :after auctex
    :init (company-auctex-init))

  (leaf company-math
    :ensure t
    :after auctex org)
  )

(leaf company-box
  :ensure t
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  )
