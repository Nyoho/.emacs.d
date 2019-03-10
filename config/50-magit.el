(use-package magit
  ;; :mode (("COMMIT_EDITMSG$" . magit-mode))

  ;; :after vc
  :config
  ;; (set-face-foreground 'magit-diff-add "green3")
  ;; (set-face-foreground 'magit-diff-del "red3")

  ;; (when (not window-system)
  ;;   (set-face-background 'magit-item-highlight "white"))

  (setq magit-auto-revert-mode nil)
  (setq magit-last-seen-setup-instructions "1.4.0")
  (setq magit-status-buffer-switch-function 'switch-to-buffer)
  ;; https://raw.githubusercontent.com/magit/magit/next/Documentation/RelNotes/1.4.0.txt

  ;; ?? 2015/4/16
  (setq magit-auto-revert-mode nil)
  ;; ??
  ;; (setq magit-last-seen-setup-instructions "1.4.0")

  (defvar magit-log-edit-confirm-cancellation nil)

  (setq vc-handled-backends '())
  ;; (eval-after-load "vc"
  ;;   '(remove-hook 'find-file-hooks 'vc-find-file-hook))
  )

