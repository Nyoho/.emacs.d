;; -*- lexical-binding: t; -*-

(leaf corfu
  :ensure t
  :custom
  (corfu-cycle . t)
  (corfu-auto . t)
  (corfu-auto-prefix . 1)
  (corfu-quit-at-boundary . nil)
  (corfu-scroll-margin . 5)
  (corfu-echo-documentation . t)
  :bind
  ((corfu-map
	 ("TAB" . corfu-insert)
	 ([tab] . corfu-insert)
     ("S-TAB" . corfu-previous)
     ("<backtab>" . corfu-previous)
	 ("C-n" . corfu-next)
	 ("C-p" . corfu-previous)))
  :init
  (global-corfu-mode))

(leaf cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions (cape-company-to-capf #'company-yasnippet))
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-tex)
  ;; (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  ;; (add-to-list 'completion-at-point-functions #'cape-ispell)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
  )


(leaf corfu-popupinfo
  :after corfu
  :hook
  (corfu-mode-hook . corfu-popupinfo-mode))

(leaf company
  :ensure t
  :disabled t
  :init
  (global-company-mode +1)
  :custom
  (completion-ignore-case . t)
  (company-idle-delay . 0)
  (company-selection-wrap-around . t)
  (company-minimum-prefix-length . 2)
  (company-dabbrev-downcase . nil)
  (company-dabbrev-other-buffers . nil)
  (company-dabbrev-code-other-buffers . nil)
  (company-dabbrev-code-everywhere . t)
  (company-require-match . 'never)
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
  :config
  (leaf company-math
    :ensure t
    :after auctex org)

  ;; yasnippetとの連携
  ;; from https://github.com/syl20bnr/spacemacs/pull/179
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
  :disabled t
  :after company
  :hook (company-mode . company-box-mode)
  :config
  (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  )

(leaf company-quickhelp
  :ensure t
  :disabled t
  :after company
  :config
  (company-quickhelp-mode))
