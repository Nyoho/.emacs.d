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


(leaf yafolding
  :ensure t)

(leaf json-mode
  :ensure t)

(leaf hs-minor-mode
  "`hs-minor-mode' 
S-<mouse-2>     hs-toggle-hiding
C-c @ C-a       hs-show-all
C-c @ C-c       hs-toggle-hiding
C-c @ C-d       hs-hide-block
C-c @ C-e       hs-toggle-hiding
C-c @ C-h       hs-hide-block
C-c @ C-l       hs-hide-level
C-c @ C-s       hs-show-block
C-c @ C-t       hs-hide-all
C-c @ ESC       Prefix Command
C-c @ C-M-h     hs-hide-all
C-c @ C-M-s     hs-show-all
")
