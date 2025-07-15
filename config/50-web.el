;; -*- lexical-binding: t; -*-
;;
;; web-mode, and related packages
;;
(leaf web-mode
  :ensure t
  :commands web-mode
  :mode ("\\.[sp]?html\\'"
         "\\.tpl\\.php\\'"
         "\\.jsp\\'"
         "\\.as[cp]x\\'"
         "\\.erb\\'"
         )
  :bind (("C-c C-v" . browse-url-of-buffer))
  :config
  (with-eval-after-load "flycheck"
    (flycheck-add-mode 'typescript-tslint 'web-mode))
  (leaf company-web
    :ensure t
    :after web-mode
    :config
    :bind ((web-mode-map ("C-'" . company-web-html)))
    :hook (web-mode-hook .(lambda ()
                            (set (make-local-variable 'company-backends)
                                 '(company-web-html company-files company-web-jade company-web-slim))
                            (company-mode t)))
    )
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
  :ensure t
  :commands sass-mode
  :mode (("\\.sass$" . sass-mode)))

;;
;; scss-mode
;;
(leaf scss-mode
  :ensure t
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


(leaf php-mode :ensure t)


(leaf slim-mode
  :ensure t)

(leaf astro-mode
  :init
  (define-derived-mode astro-mode web-mode "astro")
  :mode (".*\\.astro\\'")
  :config

  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-language-id-configuration
                 '(astro-mode . "astro"))

    (lsp-register-client
     (make-lsp-client :new-connection (lsp-stdio-connection '("astro-ls" "--stdio"))
                      :activation-fn (lsp-activate-on "astro")
                      :server-id 'astro-ls))))
