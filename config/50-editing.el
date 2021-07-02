;;; editing

(leaf expand-region
  :ensure t
  :bind (("C-," . er/expand-region) ("C-M-," . er/contract-region)))

(leaf multiple-cursors
  :ensure t
  :bind (("<C-M-return>" . mc/edit-lines)))

(leaf smartrep
  :ensure t
  :require t
  :config
  (smartrep-define-key global-map "C-."
    '(("C-n" . 'mc/mark-next-like-this)
      ("C-p" . 'mc/mark-previous-like-this)
      ("*"   . 'mc/mark-all-like-this))))

;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; region を作って M-x mc/mark-all-like-this すると同時編集
;; ここで練習してみる↓

;; abcd
;; bcde
;; cdef

;; let a = 1
;; let b = 2
;; let c = 3

(leaf outline
  :ensure t)

;; org-modeのように折り畳みができる。
(leaf outline-magic
  :ensure t)

(add-hook 'outline-mode-hook
          (lambda ()
            ))

(add-hook 'outline-minor-mode-hook
          (lambda ()
            (use-package outline-magic)
            (define-key outline-minor-mode-map [(f10)] 'outline-cycle)))

(leaf origami
    :ensure t
    :custom ((global-origami-mode . t)))

(leaf smartparens
  :ensure t)

;;
;; moccur 関連
;;
(leaf color-moccur
  :ensure t
  :config
  ;; (require 'moccur-edit)
  )
(defalias 'mg 'moccur-grep-find)
