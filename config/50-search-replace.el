;; ivy, counsel
;; Thanks, abo-abo. https://github.com/abo-abo/swiper/

(use-package counsel
  :diminish ivy-mode counsel-mode
  :bind (("M-m" . counsel-buffer-or-recentf))
  )

(use-package swiper
  :bind (("M-s" . swiper)))


(defun counsel-ag-org ()
  "org/以下を検索"
  (interactive)
  (counsel-ag "" "~/org/"))
