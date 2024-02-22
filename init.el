;;; -*- indent-tabs-mode: nil; lexical-binding: t; -*-
;;;
;;; ~/.emacs.d/init.el
;;;

(setq gc-cons-threshold (* 128 1024 1024))
(setq garbage-collection-messages t)

(setq user-full-name "nyoho")
(setq user-mail-address "algebraicallyClosedField@gmail.com")

(setq byte-compile-warnings '(not cl-functions obsolete))

;; https://gist.github.com/takaxp/ffcfbf6558a272186012b5218bc0c9fc
;; .emacs.d/init.el の先頭に記述
(defconst before-load-init-time (current-time))
(defun my:init-loading-time ()
  "Loading time of user init files including time for `after-init-hook'."
  (let ((time1 (float-time
                (time-subtract after-init-time before-load-init-time)))
        (time2 (float-time
                (time-subtract (current-time) before-load-init-time))))
    (message (concat "Loading init files: %.0f [msec], "
                     "of which %.f [msec] for `after-init-hook'.")
             (* 1000 time1) (* 1000 (- time2 time1)))))
(add-hook 'after-init-hook 'my:init-loading-time t)


;;
;; path, directories, ...
;;
(when load-file-name
  (setq user-emacs-directory
        (expand-file-name (file-name-directory load-file-name))))

(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

(eval-and-compile
  (customize-set-variable
   'package-archives '(("melpa"  . "https://melpa.org/packages/")
                       ("elpa"   . "https://elpa.gnu.org/packages/")
                       ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :doc "Additional leaf.el keywords for external packages"
    :url "https://github.com/conao3/leaf-keywords.el"
    :ensure t
    :init
    (leaf el-get
      :ensure t
      ;; :custom
      ;; (el-get-notify-type       . 'message)
      ;; (el-get-git-shallow-clone . t)
      )
    (leaf hydra :ensure t)
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))

(leaf transient
  :doc "Transient commands"
  :req "emacs-25.1"
  :tag "bindings" "emacs>=25.1"
  :url "https://github.com/magit/transient"
  :emacs>= 25.1
  :ensure t)

(leaf leaf-tree :ensure t)
(leaf leaf-convert :ensure t)

(dolist (dir (list
              "/usr/local/bin"
              "/opt/homebrew/bin"
              "/usr/bin"
              "/bin"
              "/usr/sbin"
              "/sbin"
              (expand-file-name "~/bin")
              (expand-file-name "~/.emacs.d/bin")
              ))
  ;; PATH と exec-path に同じ物を追加
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/bin/man:/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/man" (getenv "MANPATH")))
(setenv "TEXINPUTS" ".:~/tex/texinputs:")


(setq load-path
      (append (list
               "/usr/share/emacs/site-lisp/"
               "/usr/share/emacs/site-lisp/anthy/"
               "/usr/local/share/emacs/site-lisp/"
               "/usr/local/share/emacs/site-lisp/mew/"
               (concat user-emacs-directory "elisp")
               (concat user-emacs-directory "site-start.d")
               )
              load-path))

(setq exec-path
      (append (list
               "/Library/TeX/texbin"
               "/usr/bin"
               "/bin"
               "/sbin"
               "/usr/sbin"
               "/Users/nyoho/bin"
               )
              exec-path))

(defun my-add-to-load-path-directory (dir)
  "dirとdirに含まれるディレクトリをload-pathに加える"
  (setq load-path
        (append
         (cons dir
               (cl-remove-if-not (lambda (x) (file-directory-p x))
                              (mapcar (lambda (x) (concat dir "/" x))
                                      (directory-files dir nil "^[^.][^.]" t))))
         load-path)))
(defun reload-vendor-directory ()
  (interactive)
  (my-add-to-load-path-directory (concat user-emacs-directory "vendor")))
(reload-vendor-directory)


;; Setting for rbenv and TeX
(setenv "PATH"
        (concat (expand-file-name "~/.rbenv/shims:")
                (expand-file-name "~/.rbenv/bin:")
                "/Library/TeX/texbin:"
                (getenv "PATH")))
(add-to-list 'exec-path (expand-file-name "~/.rbenv/shims"))
(add-to-list 'exec-path (expand-file-name "~/.rbenv/bin"))

(leaf initchart
  :doc
  "initchart.el
  https://qiita.com/yuttie/items/0f38870817c11b2166bd
  M-x initchart-visualize-init-sequence でSVGファイル作成"
  :vc ( :url "https://github.com/yuttie/initchart")
  :require t
  :config
  ;; Measure the execution time of a specified function for every call.
  ;; Optionally, you might give a parameter name of the function you specified to
  ;; record what value is passed to the function.
  (initchart-record-execution-time-of load file)
  (initchart-record-execution-time-of require feature))

;;
;; Several settings
;;
;; font-lock, colors
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)
(require 'font-lock)

(fset 'yes-or-n-p 'y-or-n-p)

(setq comment-style 'multi-line)

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf use-package
  :doc "A configuration macro for simplifying your .emacs"
  :req "emacs-24.3" "bind-key-2.4"
  :tag "dotemacs" "startup" "speed" "config" "package" "emacs>=24.3"
  :url "https://github.com/jwiegley/use-package"
  :added "2020-03-24"
  :emacs>= 24.3
  :ensure t
  :require t
  :custom
  (use-package-compute-statistics . t)
  )

(leaf init-loader
  :ensure t
  :config
  (init-loader-load (concat user-emacs-directory "config"))
  :custom (init-loader-show-log-after-init . 'error-only)
  :require t)

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(provide 'init)
;; the end of init.el
