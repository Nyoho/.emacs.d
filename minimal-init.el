;; 別の init.el の使い方
;; (load (concat (setq user-emacs-directory "~/.emacs.d/") "minimal-init.el"))
;;
;; From command line:
;; emacs -q --eval '(load (concat (setq user-emacs-directory "~/.emacs.d/") "minimal-init.el"))'

(require 'cl)

(dolist (dir (list
              "/usr/local/bin"
              "/usr/bin"
              "/bin"
              "/usr/sbin"
              "/sbin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

;(require 'helm-config)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("ELPA" . "https://tromey.com/elpa/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(package-initialize)

(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))
(define-key global-map [ns-drag-file] 'ns-find-file)
