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
         ("\\.erb\\'" . web-mode)
         ("\\.tsx\\'" . web-mode))
  :hook
  ;; (web-mode . prettier-js-mode)
  (web-mode .  (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))
  :config
  (define-key web-mode-map (kbd "C-c C-v") 'browse-url-of-buffer)
  (flycheck-add-mode 'typescript-tslint 'web-mode)
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

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

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

