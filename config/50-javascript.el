;;
;; for js2-mode (javascript)
;;
(leaf js2-mode
  :ensure t
  :commands js2-mode js2-jsx-mode
  :mode (("\\.js\\'" . js2-mode)
         ("\\.jsx\\'" . js2-jsx-mode)
         ("components\\/.*\\.js\\'" . js2-jsx-mode))
  ;; :hook (js2-mode . prettier-js-mode)
  :custom ((js2-strict-missing-semi-warning . nil)
           (js2-basic-offset . 2)
           (js2-bounce-indent-p . t))
  :hook ((js2-jsx-mode-hook . flycheck-mode))
  :bind ((:js-mode-map ("M-." . nil)) ;; js-mode (which js2 is based on) binds "M-." which conflicts with xref, so unbind it.
         )
  :config
  ;; (flycheck-add-mode 'javascript-eslint 'js2-jsx-mode)
  ;; (add-to-list 'flycheck-checkers 'js2-jsx)
  )


;; 便利メモ
;; C-c C-a   	js2-mode-show-all
;; C-c C-e   	js2-mode-hide-element
;; C-c C-f   	js2-mode-toggle-hide-functions
;; C-c C-o   	js2-mode-toggle-element
;; C-c C-s   	js2-mode-show-element
;; C-c C-t   	js2-mode-toggle-hide-comments
;; C-c C-w   	js2-mode-toggle-warnings-and-errors


(add-to-list 'magic-mode-alist '("^import React" . rjsx-mode))

;; From http://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
(use-package js2-refactor
  :defer t
  :config
  (add-hook 'js2-mode-hook #'js2-refactor-mode)
  (js2r-add-keybindings-with-prefix "C-c C-r")
  (define-key js2-mode-map (kbd "C-k") #'js2r-kill))

(use-package xref-js2
  :defer t
  :config
  (add-hook 'js2-mode-hook (lambda ()
                             (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))

;;
;; CoffeeScript
;;
(use-package coffee-mode
  :defer t
  :config
  (setq coffee-args-compile '("-c" "-m"))
  (add-hook 'coffee-after-compile-hook 'sourcemap-goto-corresponding-point))
