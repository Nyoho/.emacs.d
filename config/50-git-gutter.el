;;
;; git-gutter.el
;;
;; (global-git-gutter-mode t)
;; (require 'git-gutter+)

;; (use-package git-gutter+
;;   :ensure t
;;   :init (global-git-gutter+-mode)
;;   :config
;;   (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
;;   (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
;;   (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
;;   (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
;;   (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
;;   (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
;;   (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
;;   (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
;;   (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer)
;;   :diminish (git-gutter+-mode . "gg"))

(use-package git-gutter
  :init
  :custom
  (git-gutter:modified-sign "~")
  (git-gutter:added-sign    "+")
  (git-gutter:deleted-sign  "-")
  :custom-face
  (git-gutter:modified ((t (:foreground "#404040" :background "#c0fc7f"))))
  (git-gutter:added    ((t (:foreground "#108a3b" :background "#50fc7f"))))
  (git-gutter:deleted  ((t (:foreground "#8f2986" :background "#ff79c6"))))
  :config
  (global-git-gutter-mode +1))

(use-package git-gutter-fringe
  :if window-system
  :init (global-git-gutter-mode t)
  :custom-face
  (git-gutter-fr:modified ((t (:foreground "#404040" :background "#c0fc7f"))))
  (git-gutter-fr:added    ((t (:foreground "#108a3b" :background "#50fc7f"))))
  (git-gutter-fr:deleted  ((t (:foreground "#8f2986" :background "#ff79c6")))))
