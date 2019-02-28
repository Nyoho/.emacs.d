;;
;; auto-complete
;;
;; (if (not linux-p)
;;     (progn
;; (global-auto-complete-mode t)
;; (require 'auto-complete)
;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")
;; (setq ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")
;; (require 'auto-complete-config)
;; (ac-config-default)
;; (add-to-list 'load-path "~/.emacs.d/elisp")
;; ))

(use-package auto-complete
  :defer t
  :config
  (setq ac-auto-show-menu 0.01)
  ;; (global-auto-complete-mode t)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (ac-set-trigger-key "TAB")

  ;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/ac-dict")
  ;; (add-to-list 'ac-dictionary-directories "~/.emacs.d/el-get/auto-complete/dict")
  )



(use-package auto-complete-latex :after auto-complete
  :defer t
  :config
  ;; (setq ac-l-dict-directory "~/.emacs.d/el-get/auto-complete-latex/ac-l-dict/")
  (setq ac-l-dict-directory "~/.emacs.d/vendor/auto-complete-latex/ac-l-dict/")
  (add-to-list 'ac-modes 'latex-mode)
  (add-hook 'LaTeX-mode-hook 'ac-l-setup))


;; (add-hook 'robe-mode-hook 'ac-robe-setup)
;; ac-math.el for mathematical symbols for auto-complete
(use-package ac-math
  :after auto-complete
  :defer t
  :config
  (add-to-list 'ac-modes 'latex-mode)
  ;; (defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  ;;   (setq ac-sources
  ;;      (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
  ;;                ac-sources))
  ;; )
  ;; (add-hook 'LaTeX-mode-hook 'ac-latex-mode-setup)
  )

(use-package ac-emoji
  :defer t
  :init
  (add-hook 'markdown-mode-hook 'ac-emoji-setup)
  (add-hook 'git-commit-mode-hook 'ac-emoji-setup)
  :config
  )

(use-package ac-octave :after auto-complete :defer t)
(use-package auto-complete-config
  :after auto-complete
  :defer t
  :config
  (ac-config-default)
  )

;; (add-hook 'emacs-startup-hook
;;           (function (lambda ()
;;                       (require 'auto-complete-config)
;;                       (ac-config-default))))
