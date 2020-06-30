;; ivy, counsel
;; Thanks, abo-abo. https://github.com/abo-abo/swiper/

(leaf counsel
  :ensure t
  :diminish ivy-mode counsel-mode
  :bind (("M-m" . counsel-buffer-or-recentf)
         ("C-x b" . counsel-switch-buffer)
         ("M-g ." . counsel-rg)))

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
    :when window-system
    :init (all-the-icons-ivy-rich-mode 1))

  (leaf ivy-rich
    :ensure t
    :when window-system
    :init (ivy-rich-mode 1))
  )

(leaf swiper
  :ensure t
  :after dash s
  :commands swiper swiper-all
  :bind (("M-s" . swiper)
         ("C-M-s" . swiper-all-thing-at-point))
  :custom ((ivy-re-builders-alist . '((t . ivy--regex-plus)
                                      (counsel-rg . ytn-ivy-migemo-re-builder)
                                      (swiper . ytn-ivy-migemo-re-builder))))
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
  "~/org/以下を検索"
  (interactive)
  (counsel-rg "" "~/org/"))

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
