;;; editing

(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-,") 'er/expand-region)
  (global-set-key (kbd "C-M-,") 'er/contract-region))

(use-package multiple-cursors :defer t)
(use-package smartrep
  :ensure t
  :config
  (smartrep-define-key
      global-map "C-." '(("C-n" . 'mc/mark-next-like-this)
                         ("C-p" . 'mc/mark-previous-like-this)
                         ("*"   . 'mc/mark-all-like-this))))

;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(global-set-key (kbd "<C-M-return>") 'mc/edit-lines)

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

