;; ivy, counsel
;; Thanks, abo-abo. https://github.com/abo-abo/swiper/

(leaf counsel
  :ensure t
  :diminish ivy-mode counsel-mode
  :commands counsel-buffer-or-recentf counsel-switch-buffer
  :bind (("M-m" . counsel-buffer-or-recentf)
         ("C-x b" . counsel-switch-buffer)
         ("M-g ." . counsel-ag)))

(leaf ivy
  :ensure t
  :require t
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
    :init (all-the-icons-ivy-rich-mode 1))

  (leaf ivy-rich
    :ensure t
    :init (ivy-rich-mode 1))
  )

(leaf swiper
  :ensure t
  :commands swiper swiper-all
  :bind (("M-s" . swiper)
         ("C-M-s" . swiper-all-thing-at-point))
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
  :advice ((:override swiper-all-thing-at-point ad:swiper-all-thing-at-point)))


(defun counsel-ag-org ()
  "~/org/以下を検索"
  (interactive)
  (counsel-ag "" "~/org/"))

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
  :after ivy-prescient
  :custom
  `((prescient-aggressive-file-save . t)
    (prescient-save-file . ,(expand-file-name "~/.emacs.d/prescient-save.el")))
  :config
  (prescient-persist-mode 1))

(leaf ivy-prescient
  :ensure t
  :require t
  :config
  (ivy-prescient-mode 0))
