
(use-package company
  :ensure t
  :init
  (global-company-mode +1)
  :custom
  (completion-ignore-case t)
  (company-idle-delay 0)
  (company-selection-wrap-around t)
  :config
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)
  (define-key company-active-map (kbd "C-i") 'company-complete-selection)
  (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
  )

(use-package company-box
  :ensure t
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  )
