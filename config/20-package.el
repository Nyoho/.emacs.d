;;
;; package.el
;;

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("ELPA" . "https://tromey.com/elpa/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

;; (("ELPA" . "http://tromey.com/elpa/")
;;  ("gnu" . "https://elpa.gnu.org/packages/")
;;  ("melpa" . "https://melpa.org/packages/")
;;  ("org" . "http://orgmode.org/elpa/"))


;; (when (require 'package nil t)
;;   ;; (setq package-user-dir "~/.emacs.d/package/elpa/")
;;   ;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;   (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;   (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
;;   ;; インストールしたパッケージにロードパスを通してロードする
;;   (package-initialize))

;; (require 'package nil t)
;; (setq package-user-dir "~/.emacs.d/package/elpa/")
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;; (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
;; ;; インストールしたパッケージにロードパスを通してロードする
;; (package-initialize)
