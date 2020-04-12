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

(leaf rjsx-mode
  :ensure t
  :magic ("^import React" . rjsx-mode))

;; From http://emacs.cafe/emacs/javascript/setup/2017/04/23/emacs-setup-javascript.html
(leaf js2-refactor
  :after t
  :bind ((js2-mode-map ("C-k" . js2r-kill)))
  :hook ((js2-mode-hook . js2-refactor-mode))
  :config (js2r-add-keybindings-with-prefix "C-c C-r"))

(leaf xref-js2
  :after js2
  :hook (js2-mode-hook . (lambda ()
                           (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t))))
;;
;; CoffeeScript
;;
(leaf coffee-mode
  :after t
  :hook ((coffee-after-compile-hook . sourcemap-goto-corresponding-point))
  :setq ((coffee-args-compile quote ("-c" "-m"))))
