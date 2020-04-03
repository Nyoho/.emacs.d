;; ivy, counsel
;; Thanks, abo-abo. https://github.com/abo-abo/swiper/

(use-package counsel
  :ensure t
  :diminish ivy-mode counsel-mode
  :bind (("M-m" . counsel-buffer-or-recentf)
         ("C-x b" . counsel-switch-buffer))
  )

(leaf ivy
  :ensure t
  :require t)

(use-package swiper
  :ensure t
  :bind (("M-s" . swiper)))


(defun counsel-ag-org ()
  "org/以下を検索"
  (interactive)
  (counsel-ag "" "~/org/"))

(leaf visual-regexp
  :ensure t
  :bind (("M-%" . vr/query-replace)))
