;; -*- lexical-binding: t; -*-
;;
;; POV-Ray mode
;;

;; (add-to-list 'load-path "~/.emacs.d/elisp/pov-mode-3.2")
;; (autoload 'pov-mode "pov-mode.el" "POV-Ray mode" t)
;; (add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
;; (add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))
;; (setq povray-command "megapov")

;; (add-hook 'pov-mode-hook
;;   '(lambda ()
;;     (define-key pov-mode-map "\C-c\C-c" 'pov-scene-render)))
;; (defvar pov-render-option nil)
;; (defvar povray-path "pvmegapov")
;; (defvar povray-path "megapov")
;; (defun pov-scene-render ()
;;   (interactive)
;;   (if (buffer-modified-p) (pov-ask-save-buffer))
;;   (setq pov-render-option (read-from-minibuffer "Commandline Option?: "))
;;   (if (get-process "pov-ray") (delete-process "pov-ray"))
;;   (start-process
;;    povray-path povray-path povray-path
;;    (concat "+FN +L" (file-name-directory(buffer-file-name))
;;           " +I" (file-name-nondirectory(buffer-file-name))
;;           " " pov-render-option)))
;; (defun pov-ask-save-buffer ()
;;   (let (A)
;;     (setq A (read-from-minibuffer "This buffer is modified. Save it? (y, n): "))
;;     (if (string= A "y") (save-buffer)
;;       (if (string= A "n") () (pov-ask-save-buffer)))))

(leaf pov-mode
  :ensure t
  :config
  (if (file-directory-p "/Applications/POV-Ray3_7_Mac_Unofficial/Insert Menu/")
      (setq pov-insertmenu-location "/Applications/POV-Ray3_7_Mac_Unofficial/Insert Menu/"))
  )


