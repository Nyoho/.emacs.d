(leaf magit
  :ensure t
  ;; :mode (("COMMIT_EDITMSG$" . magit-mode))

  ;; :after vc
  :setq ((magit-auto-revert-mode . nil) ;; ?? 2015/4/16
         (magit-last-seen-setup-instructions . "1.4.0")
         ;; https://raw.githubusercontent.com/magit/magit/next/Documentation/RelNotes/1.4.0.txt
         (magit-status-buffer-switch-function . 'switch-to-buffer)
         (magit-log-edit-confirm-cancellation . nil)
         (vc-handled-backends . '()))
  :config
  ;; (set-face-foreground 'magit-diff-add "green3")
  ;; (set-face-foreground 'magit-diff-del "red3")

  ;; (when (not window-system)
  ;;   (set-face-background 'magit-item-highlight "white"))
  ;; (eval-after-load "vc"
  ;;   '(remove-hook 'find-file-hooks 'vc-find-file-hook))
  :custom
  ((magit-log-margin . '(t "%Y-%m-%d %H:%M:%S" magit-log-margin-width t 12))))

(leaf forge
  :ensure t
  :after magit)

(leaf magit-delta
  :when (executable-find "delta")
  :ensure t
  :after magit
  :hook (magit-mode-hook))
