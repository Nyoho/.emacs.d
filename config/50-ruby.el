
(leaf ruby-mode
  ;; :preface
  ;; (defun ruby-mode-set-encoding nil)
  :mode ("\\.rake$" "Rakefile$" "\\.gemspec$" "\\.ru$" "Gemfile$" "Guardfile$")
  :custom
  (ruby-insert-encoding-magic-comment . nil))

;;
;; robe
;;
(leaf robe
  :ensure t
  :config
  (autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
  (autoload 'robe-ac-setup "robe-ac" "robe auto-complete" nil nil)
  (add-hook 'robe-mode-hook 'robe-ac-setup)
  )

(leaf enh-ruby-mode
  :doc "An enhanced ruby-mode"
  :ensure t
  :config
  (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)

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



(leaf inf-ruby
  :ensure t
  :config
  (setq inf-ruby-default-implementation "pry")
  (setq inf-ruby-eval-binding "Pry.toplevel_binding")
  (add-hook 'inf-ruby-mode-hook 'ansi-color-for-comint-mode-on))

;; in ~/.pryrc
;; Pry.config.editor = "emacsclient"


(leaf feature-mode
  :doc "cucumber.el"
  :url "https://github.com/michaelklishin/cucumber.el"
  :ensure t)
