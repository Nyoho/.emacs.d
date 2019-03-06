;;
;; web-mode, and related packages
;;
(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.shtml\\'" . web-mode)
         ("\\.phtml\\'" . web-mode)
         ("\\.tpl\\.php\\'" . web-mode)
         ("\\.jsp\\'" . web-mode)
         ("\\.as[cp]x\\'" . web-mode)
         ("\\.erb\\'" . web-mode))
  ;; :hook (web-mode . prettier-js-mode)
  :config
  (define-key web-mode-map (kbd "C-c C-v") 'browse-url-of-buffer)
  )
;; (eval-after-load 'web-mode
;;   '(defun-add-hook 'web-mode-hook
;;      (setq web-mode-html-offset   4)
;;      (setq web-mode-css-offset    4)
;;      (setq web-mode-script-offset 4)
;;      (setq web-mode-php-offset    4)
;;      (setq indent-tabs-mode nil)
;;      (setq tab-width 4)))
;; (eval-after-load 'web-mode
;;   '(defun-add-hook 'web-mode-hook
;;      (setq web-mode-html-offset   4)
;;      (setq web-mode-css-offset    4)
;;      (setq web-mode-script-offset 4)
;;      (setq web-mode-php-offset    4)
;;      (setq indent-tabs-mode nil)
;;      (setq tab-width 4)))

;;
;; for css-mode
;;
(use-package css-mode
  :mode (("\\.css\\'" . css-mode))
  :config
  (setq cssm-indent-function 'cssm-c-style-indenter)
  )


;;
;; sass-mode
;;
(use-package sass-mode
  :defer t
  :mode (("\\.sass$" . sass-mode)))


;;
;; scss-mode
;;
(use-package scss-mode
  :defer t
  :mode (("\\.scss\\'" . scss-mode))
  :config
  (setq scss-compile-at-save nil))

;; (setq js2-basic-offset 4)
;; (setq web-mode-markup-indent-offset 2)


;;
;; haml-mode
;;
(use-package haml-mode
  :defer t
  :mode (("\\.haml$" . haml-mode)))

