;;
;; ruby-mode
;;
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(defun ruby-mode-set-encoding ())
(setq ruby-insert-encoding-magic-comment nil)


(use-package ruby-refactor
  :defer t)
;; (use-package ruby-mode
;;   :hook ruby-refactor-mode-launch
;;   :hook robe-mode)

;;
;; robe
;;
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
(autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
(add-hook 'robe-mode-hook 'robe-ac-setup)

(use-package helm-robe
  :defer t
  :config
  (custom-set-variables '(robe-completing-read-func 'helm-robe-completing-read))
  )

;; enhanced(enh)-ruby-mode
(use-package enh-ruby-mode
  :defer t
  :config
  ;; 保存時にmagic commentを追加しないようにする
  (defadvice enh-ruby-mode-set-encoding (around stop-enh-ruby-mode-set-encoding)
    "If enh-ruby-not-insert-magic-comment is true, stops enh-ruby-mode-set-encoding."
    (if (and (boundp 'enh-ruby-not-insert-magic-comment)
             (not enh-ruby-not-insert-magic-comment))
        ad-do-it))
  (ad-activate 'enh-ruby-mode-set-encoding)
  (setq-default enh-ruby-not-insert-magic-comment t))


;;
;; for rcodetools
;;
;; /usr/lib64/ruby/gems/1.8/gems/rcodetools-0.8.5.0/README.emacs
(use-package rcodetools
  :defer t
  :config
  ;; (require 'icicles-rcodetools)

  ;; (describe-function 'xmp)
  ;; (describe-function 'comment-dwim)

  (setq rct-find-tag-if-available nil)
  (defun ruby-mode-hook-rcodetools ()
    (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
    (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
    (define-key ruby-mode-map "\C-c\C-d" 'xmp)
    (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
  (add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

  ;; (require 'anything-rcodetools)
  ;; (setq rct-get-all-methods-command "PAGER=cat fri -l")
  )


;;
;; ruby-electric
;;
;; (require 'ruby-electric)
;; (add-hook 'ruby-mode-hook (lambda () (ruby-electric-mode 1)))



(use-package inf-ruby
  :defer t
  :config
  (setq inf-ruby-default-implementation "pry")
  (setq inf-ruby-eval-binding "Pry.toplevel_binding")
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on)
  )

;; in ~/.pryrc
;; Pry.config.editor = "emacsclient"

