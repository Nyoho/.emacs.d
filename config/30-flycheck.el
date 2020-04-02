(leaf flycheck
  :ensure t
  :custom ((flycheck-pos-tip-timeout . 30))
  :config
  ;; (add-hook 'after-init-hook #'global-flycheck-mode)

  ;; (flycheck-def-option-var flycheck-d-custom-import-paths nil d-dmd
  ;;   "A list of additional import paths."
  ;;   :type '(repeat :tag "Additional paths"
  ;;           (string :tag "import path"))
  ;;   :safe #'flycheck-string-list-p
  ;;   :package-version '(flycheck . "0.14"))

  ;; (put 'd-dmd :flycheck-command
  ;;      (append (flycheck-checker-command 'd-dmd)
  ;;              '((option-list "-I" flycheck-d-custom-import-paths s-prepend))))

  ;; flycheck-pos-tip
  ;; (flycheck-pos-tip-mode)
  ;; (setq flycheck-pos-tip-timeout 30)
  )

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
