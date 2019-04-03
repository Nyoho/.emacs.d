;;
;; for dired
;;
(use-package dired-x
  :after dired
  :defer t
  :init
  (defface my-face-f-2 '((t (:foreground "yellow"))) nil)
  (defvar my-face-f-2 'my-face-f-2)
  (defun my-dired-today-search (arg)
    "Fontlock search function for dired."
    (search-forward-regexp
     (concat (format-time-string "%Y-%m-%d" (current-time)) " [0-9]....") arg t))

  (add-hook 'dired-mode-hook
            '(lambda ()
               (font-lock-add-keywords
                major-mode
                (list
                 '(my-dired-today-search . my-face-f-2)
                 ))))
  (defun dired-mode-hooks()
    (dired-filter-mode))
  (add-hook 'dired-mode-hook 'dired-mode-hooks)

  :config
  ;; dired + sorter 時に ls の -h オプションを付加する
  (defadvice dired-sort-other
      (around dired-sort-other-h activate)
    (ad-set-arg 0 (concat (ad-get-arg 0) "h"))
    ad-do-it
    (setq dired-actual-switches (dired-replace-in-string "h" "" dired-actual-switches)))

  (setq dired-dwim-target t)

  ;; dired-filter-group
  (setq dired-filter-group-saved-groups
        '(("default"
           ("TeX/LaTeX"
            (extension "tex" "bib"))
           ("Org"
            (extension . "org"))
           ("PDF"
            (extension . "pdf"))
           ("Images"
            (extension "png" "jpg" "jpeg" "tiff" "bmp"))
           ("Programs"
            (extension "c" "m" "cpp" "rb" "py" "swift" "h"))
           ("POV-Ray"
            (extension "pov"))
           ("Archives"
            (extension "gz" "bz2" "xz" "tar" "zip" "rar")))))
  )


;;
;; for wdired
;;
(use-package wdired
  :after dired
  :config
  (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
  )

;;
;; dired-subreee
;; http://emacs.rubikitch.com/dired-subtree/
;;
(use-package dired-subtree
  :after dired
  :config
  (define-key dired-mode-map (kbd "i") 'dired-subtree-insert)
  ;; org-modeのように
  (define-key dired-mode-map (kbd "<tab>") 'dired-subtree-remove)
  (define-key dired-mode-map (kbd "C-x n n") 'dired-subtree-narrow)

;;; [2014-12-30 Tue]^をdired-subtreeに対応させる
  (defun dired-subtree-up-dwim (&optional arg)
    "subtreeの親ディレクトリに移動。そうでなければ親ディレクトリを開く(^の挙動)。"
    (interactive "p")
    (or (dired-subtree-up arg)
        (dired-up-directory)))
  (define-key dired-mode-map (kbd "^") 'dired-subtree-up-dwim)

  ;; 2 windows が両方 dired のときに copy や rename が楽になる。リモートでも動作するので便利。
  (setq dired-dwim-target t)
  )
