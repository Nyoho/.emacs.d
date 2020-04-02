;;
;; web-mode, and related packages
;;
(leaf web-mode
  :ensure t
  :after flycheck
  :commands web-mode
  :mode ("\\.[sp]?html\\'"
         "\\.tpl\\.php\\'"
         "\\.jsp\\'"
         "\\.as[cp]x\\'"
         "\\.erb\\'"
         "\\.tsx\\'")
  :bind (("C-c C-v" . browse-url-of-buffer))
  :config
  (flycheck-add-mode 'typescript-tslint 'web-mode)
  :hook (web-mode-hook . (lambda ()
                           (when (string-equal "tsx" (file-name-extension buffer-file-name))
                             (setup-tide-mode)))))

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
(leaf css-mode
  :ensure t
  :commands css-mode
  :mode ("\\.css\\'")
  :custom (cssm-indent-function . 'cssm-c-style-indenter))

;;
;; sass-mode
;;
(leaf sass-mode
  :commands sass-mode
  :mode (("\\.sass$" . sass-mode)))

;;
;; scss-mode
;;
(leaf scss-mode
  :commands scss-mode
  :mode (("\\.scss\\'" . scss-mode))
  :config
  (with-eval-after-load (quote scss-mode) (setq scss-compile-at-save nil)))

;; (setq js2-basic-offset 4)
;; (setq web-mode-markup-indent-offset 2)


;;
;; haml-mode
;;
(leaf haml-mode
  :ensure t
  :commands haml-mode
  :mode (("\\.haml$" . haml-mode)))
