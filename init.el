;;; -*- indent-tabs-mode: nil; lexical-binding: t; -*-
;;;
;;; ~/.emacs.d/init.el
;;;

(setq gc-cons-threshold (* 128 1024 1024))
(setq garbage-collection-messages t)

(setq user-full-name "nyoho")
(setq user-mail-address "algebraicallyClosedField@gmail.com")

(setq byte-compile-warnings '(not cl-functions obsolete))
(require 'cl)

(cd "~")

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
              "/opt/homebrew/bin"
              "/usr/local/bin"
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
               "/usr/local/bin"
               "/usr/bin"
               "/bin"
               "/sbin"
               "/usr/sbin"
               "/Users/nyoho/bin"
               "/usr/share/emacs/site-lisp/"
               "/usr/share/emacs/site-lisp/anthy/"
               "/usr/local/share/emacs/site-lisp/"
               )
              exec-path))

(defun my-add-to-load-path-directory (dir)
  "dirとdirに含まれるディレクトリをload-pathに加える"
  (setq load-path
        (append
         (cons dir
               (remove-if-not (lambda (x) (file-directory-p x))
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


;; Emacs の種類バージョンを判別するための変数を定義
;; see http://github.com/elim/dotemacs/blob/master/init.el
(defun x->bool (elt) (not (not elt)))
(defvar emacs22-p (equal emacs-major-version 22))
(defvar emacs23-p (equal emacs-major-version 23))
(defvar emacs23+p (>= emacs-major-version 23))
(defvar darwin-p (eq system-type 'darwin))
;;(defvar ns-p (featurep 'ns))
(defvar ns-p (eq window-system 'ns))
(defvar carbon-p (and (eq window-system 'mac) emacs22-p))
;; (defvar mac-p (and (eq window-system 'mac) emacs23+p))
(defvar mac-p (memq window-system '(mac ns)))
(defvar linux-p (eq system-type 'gnu/linux))
(defvar colinux-p (when linux-p
                    (let ((file "/proc/modules"))
                      (and
                       (file-readable-p file)
                       (x->bool
                        (with-temp-buffer
                          (insert-file-contents file)
                          (goto-char (point-min))
                          (re-search-forward "^cofuse\.+" nil t)))))))
(defvar cygwin-p (eq system-type 'cygwin))
(defvar nt-p (eq system-type 'windows-nt))
(defvar meadow-p (featurep 'meadow))
(defvar windows-p (or cygwin-p nt-p meadow-p))

;;
;; initchart.el
;; https://qiita.com/yuttie/items/0f38870817c11b2166bd
;; M-x initchart-visualize-init-sequence でSVGファイル作成
(require 'initchart)
;; Measure the execution time of a specified function for every call.
;; Optionally, you might give a parameter name of the function you specified to
;; record what value is passed to the function.
(initchart-record-execution-time-of load file)
(initchart-record-execution-time-of require feature)

;;
;; Several settings
;;
;; font-lock, colors
(setq font-lock-use-default-fonts nil)
(setq font-lock-use-default-colors nil)
(global-font-lock-mode t)
(setq font-lock-support-mode 'jit-lock-mode)
(require 'font-lock)

(fset 'yes-or-n-p 'y-or-n-p)

(setq comment-style 'multi-line)

;; 起動時間計測
(when emacs23+p
  (defun message-startup-time ()
    (message "Emacs loaded in %dms"
             (/ (- (+ (third after-init-time) (* 1000000 (second after-init-time)))
                   (+ (third before-init-time) (* 1000000 (second before-init-time))))
                1000)))
  (add-hook 'after-init-hook 'message-startup-time))


;;
;; 標準 Elisp の設定
;;(load "config/builtins")

;; 非標準 Elisp の設定
;;(load "config/packages")

;; 個別の設定があったら読み込む
;;
;;(condition-case err
;;   (load "config/local")
;;  (error))

;; (load "config/init" t)
;; init-loader に置き換えた


(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

;; (require 'cask "~/.cask/cask.el")
;; (cask-initialize)

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
  :init (init-loader-load (concat user-emacs-directory "config"))
  :custom ((init-loader-show-log-after-init quote error-only))
  :require t)

;; esup: the Emacs StartUp Profiler
(leaf esup
  :ensure t)
(leaf noflet
  :ensure t)
(defun esup-init-loader ()
  (interactive)
  (let ((files)
        (esup-user-init-file "/tmp/esup-init.el"))
    (noflet ((load (file &rest _) (push (locate-library file) files)))
            (init-loader-load (concat user-emacs-directory "config")))
    (with-current-buffer (find-file-noselect esup-user-init-file)
      (erase-buffer)
      (dolist (file (reverse files))
        (insert-file-contents file)
        (goto-char (point-max)))
      (save-buffer))
    (esup)))

(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

(add-hook 'after-init-hook
          (lambda ()
            (message "--- Emacs booting time: %.3f [msec]"
                     (* 1
                        (float-time (time-subtract
                                     after-init-time
                                     before-init-time))))))

(provide 'init)
;; the end of init.el
