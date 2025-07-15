;; -*- lexical-binding: t; -*-
;; https://github.com/sagemath/sage-shell-mode

(leaf sage-shell-mode
  :ensure t
  ;; Turn on eldoc-mode in Sage terminal and in Sage source files
  :hook ((sage-shell-mode-hook . eldoc-mode)
         (sage-shell:sage-mode-hook . eldoc-mode))
  :config
  (setq sage-shell:use-prompt-toolkit nil)
  (setq sage-shell:sage-root "/Applications/SageMath-8.6.app")
  ;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
  (sage-shell:define-alias)
  )

;; これはまだ
;; https://bitbucket.org/gvol/sage-mode
;; (require 'sage "sage")
;; (setq sage-command "/usr/local/bin/sage")
