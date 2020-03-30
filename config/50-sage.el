;; https://github.com/sagemath/sage-shell-mode

(use-package sage-shell-mode
  :ensure t
  :config
  (setq sage-shell:use-prompt-toolkit nil)
  (setq sage-shell:sage-root "/Applications/SageMath-8.6.app")
  ;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
  (sage-shell:define-alias)

  ;; Turn on eldoc-mode in Sage terminal and in Sage source files
  (add-hook 'sage-shell-mode-hook #'eldoc-mode)
  (add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)
  )

;; これはまだ
;; https://bitbucket.org/gvol/sage-mode
;; (require 'sage "sage")
;; (setq sage-command "/usr/local/bin/sage")
