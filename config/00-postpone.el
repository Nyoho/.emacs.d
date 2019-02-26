;;
;; postpone.el
;; https://qiita.com/takaxp/items/c01fb7737496af9a8fcd
(if (not (locate-library "postpone"))
    (message "postpone.el is NOT installed.")
  (autoload 'postpone-kicker "postpone" nil t)
  (defun my-postpone-kicker ()
    (interactive)
    (unless (memq this-command ;; specify commands for exclusion
                  '(self-insert-command
                    save-buffers-kill-terminal
                    exit-minibuffer))
      (message "Activating postponed packages...")
      (let ((t1 (current-time)))
        (postpone-kicker 'my-postpone-kicker)
        (setq postpone-init-time (float-time
                                  (time-subtract (current-time) t1))))
      (message "Activating postponed packages...done")))
  (add-hook 'pre-command-hook #'my-postpone-kicker))
