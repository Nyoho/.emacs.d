;; -*- lexical-binding: t; -*-

(leaf magit
  :ensure t
  ;; :mode (("COMMIT_EDITMSG$" . magit-mode))

  ;; :after vc
  :setq ((magit-auto-revert-mode . nil) ;; ?? 2015/4/16
         (magit-last-seen-setup-instructions . "1.4.0")
         ;; https://raw.githubusercontent.com/magit/magit/next/Documentation/RelNotes/1.4.0.txt
         (magit-status-buffer-switch-function . 'switch-to-buffer)
         (magit-log-edit-confirm-cancellation . nil)
         )
  :bind
  ("C-x m"  . magit-status)
  :config
  ;; (set-face-foreground 'magit-diff-add "green3")
  ;; (set-face-foreground 'magit-diff-del "red3")

  ;; (when (not window-system)
  ;;   (set-face-background 'magit-item-highlight "white"))
  ;; (eval-after-load "vc"
  ;;   '(remove-hook 'find-file-hooks 'vc-find-file-hook))

  (setq magit-status-sections-hook
        '(magit-insert-status-headers
          magit-insert-merge-log
          magit-insert-rebase-sequence
          magit-insert-am-sequence
          magit-insert-sequencer-sequence
          magit-insert-bisect-output
          magit-insert-bisect-rest
          magit-insert-bisect-log
          magit-insert-untracked-files
          magit-insert-unstaged-changes
          magit-insert-staged-changes
          magit-insert-stashes
          magit-insert-unpushed-to-pushremote
          magit-insert-unpushed-to-upstream-or-recent
          magit-insert-unpulled-from-pushremote
          magit-insert-unpulled-from-upstream))

  ;; 非常に遅いリポジトリのとき一時的に次を試す。
  ;; (setq magit-diff-highlight-trailing  nil
  ;;       magit-diff-paint-whitespace    nil
  ;;       magit-diff-highlight-hunk-body nil)

  :custom
  ((magit-log-margin . '(t "%Y-%m-%d %H:%M:%S" magit-log-margin-width t 12))))

(leaf forge
  :ensure t
  :after magit)

(leaf magit-delta
  :when (executable-find "delta")
  :ensure t
  :after magit
  :hook (magit-mode-hook . magit-delta-mode))
