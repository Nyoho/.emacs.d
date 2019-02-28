;;
;; install-elisp, auto-install
;;

;; (use-package install-elisp
;;   :config
;;   (setq install-elisp-repository-directory "~/.emacs.d/elisp/")
;;   )

;; ;; (2) And put the following in your ~/.emacs startup file:
;; (use-package auto-install
;;   :config
;;   ;; (3) Add this to your ~/.emacs to optionally specify a download directory:
;;   (setq auto-install-directory "~/.emacs.d/elisp/")
;;   (add-to-list 'load-path auto-install-directory)
;;   ;; (4) Optionally, if your computer is always connected Internet when Emacs start up,
;;   ;;     I recommend you add below to your ~/.emacs, to update package name when start up:
;;   (auto-install-update-emacswiki-package-name t)
;;   ;;     And above setup is not necessary, because AutoInstall will automatically update
;;   ;;     package name when you just first call `auto-install-from-emacswiki',
;;   ;;     above setup just avoid *delay* when you first call `auto-install-from-emacswiki'.
;;   ;;
;;   ;; (5) I recommend you add below to your ~/.emacs for install-elisp users:
;;   (auto-install-compatibility-setup)
;;   ;; I use wget (thanks to rubikitch sensei)
;;   (setq auto-install-use-wget t)
;;   )
