;;-*-emacs-lisp-*-

;;
;; Macaulay 2
;;
(setq M2-shell-exe "/usr/local/bin/zsh")
(setq M2-exe "/Applications/Macaulay2/bin/M2 --no-readline --print-width 99")

(cond ((file-exists-p "/Applications/Macaulay2/share/emacs/site-lisp")

    ;; add "/Applications/Macaulay2/share/emacs/site-lisp" to load-path if it isn't there
    (if (not (member "/Applications/Macaulay2/share/emacs/site-lisp" load-path))
        (setq load-path (cons "/Applications/Macaulay2/share/emacs/site-lisp" load-path)))

  ;; add "/Applications/Macaulay2/bin" to exec-path if it isn't there
  (if (not (member "/Applications/Macaulay2/bin" exec-path))
      (setq exec-path (cons "/Applications/Macaulay2/bin" exec-path)))

  ;; add "/Applications/Macaulay2/share/info" to Info-default-directory-list if it isn't there
  (if (not (member "/Applications/Macaulay2/share/info" Info-default-directory-list))
      (setq Info-default-directory-list (cons "/Applications/Macaulay2/share/info" Info-default-directory-list)))

  ;; this version will give an error if M2-init.el is not found:
  (load "M2-init")

  ;; this version will not give an error if M2-init.el is not found:
  ;;(load "M2-init" t)
  ;; You may comment out the following line with an initial semicolon if you 
  ;; want to use your f12 key for something else.  However, this action
  ;; will be undone the next time you run setup() or setupEmacs().
  ;; (global-set-key [ f12 ] 'M2)

  (add-hook 'M2-mode-hook (lambda ()
                            (define-key M2-mode-map (kbd "C-j") 'M2-send-to-program)))

  ))

