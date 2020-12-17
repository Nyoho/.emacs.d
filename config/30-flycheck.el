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

  (flycheck-define-checker textlint
    "A linter called textlint."
    :command ("textlint" "--format" "unix" source)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message (one-or-more not-newline)
                       (zero-or-more "\n" (any " ") (one-or-more not-newline)))
              line-end))
    :modes (text-mode markdown-mode gfm-mode review-mode))
  (add-to-list 'flycheck-checkers 'textlint)
  )

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
