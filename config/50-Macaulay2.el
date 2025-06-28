;; -*- lexical-binding: t; -*-
;;-*-emacs-lisp-*-

;;
;; Macaulay 2
;;
;; brew install Macaulay2/tap/M2
(leaf *Macaulay2
  :if (file-exists-p "/usr/local/bin/M2")
;  :mode (("\\.m2\\'" . M2-mode))
  :setq ((M2-shell-exe . "/usr/local/bin/zsh")
         ;; (M2-exe . "/Applications/Macaulay2/bin/M2 --no-readline --print-width 99")
         (M2-exe . "/usr/local/bin/M2 --no-readline --print-width 99"))
  :config
  (cond
   ((file-exists-p "/Applications/Macaulay2/share/emacs/site-lisp")
    (if (not (member "/Applications/Macaulay2/share/emacs/site-lisp" load-path))
        (setq load-path (cons "/Applications/Macaulay2/share/emacs/site-lisp" load-path)))
    (if (not (member "/Applications/Macaulay2/bin" exec-path))
        (setq exec-path (cons "/Applications/Macaulay2/bin" exec-path)))
    (if (not (member "/Applications/Macaulay2/share/info" Info-default-directory-list))
        (setq Info-default-directory-list (cons "/Applications/Macaulay2/share/info" Info-default-directory-list)))
    ))
  (if (file-exists-p "/usr/local/share/emacs/site-lisp/macaulay2")
   (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/macaulay2"))
  
  ;; this version will give an error if M2-init.el is not found:
  (load "M2-init")

  ;; this version will not give an error if M2-init.el is not found:
  ;;(load "M2-init" t)
  ;; You may comment out the following line with an initial semicolon if you 
  ;; want to use your f12 key for something else.  However, this action
  ;; will be undone the next time you run setup() or setupEmacs().
  ;; (global-set-key [ f12 ] 'M2)

  (add-hook 'M2-mode-hook
            (lambda ()
              (define-key M2-mode-map
                (kbd "C-j")
                'M2-send-to-program))))
