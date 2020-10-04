;; ここを参考にして実験中
;; https://github.com/syohex/dot_files/blob/master/emacs/init_loader/99_global-keys.el

;; (global-set-key (kbd "M-s") 'helm-occur)


(global-set-key (kbd "C-t") 'switch-to-last-buffer-or-other-window)

;;  (global-set-key [?\e ?\[ ?d] 'windmove-left)
;;  (global-set-key [?\e ?\[ ?a] 'windmove-up)
;;  (global-set-key [?\e ?\[ ?c] 'windmove-right)
;;  (global-set-key [?\e ?\[ ?b] 'windmove-down)
;;  (global-set-key "\e[d" 'windmove-left)
;;  (global-set-key "\e[a" 'windmove-up)
;;  (global-set-key "\e[c" 'windmove-right)
;;  (global-set-key "\e[b" 'windmove-down)
;;  (global-set-key [M-left] 'windmove-left)
;;  (global-set-key "\e[a" 'windmove-up)
;;  (global-set-key [M-right] 'windmove-right)
;;  (global-set-key "\e[b" 'windmove-down)




(global-set-key (kbd "C-x C-b") 'ibuffer)


;; (global-set-key (kbd "M-[") 'backward-paragraph)
;; (global-set-key (kbd "M-]") 'forward-paragraph)


;; helm
;; (global-set-key (kbd "C-x C-a") 'find-file-in-project)
(global-set-key (kbd "C-x C-a") 'counsel-git)
(global-set-key (kbd "C-x C-g") 'counsel-git-grep)
;; (global-set-key (kbd "C-x C-g") 'helm-git-grep-at-point)

;; (require 'helm-ls-git)
;; (global-set-key (kbd "C-x C-a") 'helm-ls-git)

;; Move from helm to ivy
;; (global-set-key (kbd "M-m") 'my-helm)
;; (global-set-key (kbd "M-y") 'helm-show-kill-ring)

;; (global-set-key [remap execute-extended-command] #'helm-smex)
;; (global-set-key (kbd "M-X") #'helm-smex-major-mode-commands)

(global-set-key [remap execute-extended-command] #'counsel-M-x)
(global-set-key (kbd "M-X") #'smex-major-mode-commands)

(global-set-key (kbd "C-x C-f") 'counsel-find-file)

;; helm-calcul-expression で bc みたいなのが計算できる


;; Ctrl-q map
(defvar my/ctrl-q-map (make-sparse-keymap)
  "My keymap binded to Ctrl-q.")
(defalias 'my/ctrl-q-prefix my/ctrl-q-map)
(define-key global-map (kbd "C-q") 'my/ctrl-q-prefix)
(define-key my/ctrl-q-map (kbd "C-q") 'quoted-insert)
(define-key my/ctrl-q-map (kbd "C-c") 'column-highlight-mode)
(define-key my/ctrl-q-map (kbd "C-a") 'text-scale-adjust)
(define-key my/ctrl-q-map (kbd "C-f") 'flyspell-mode)
(define-key my/ctrl-q-map (kbd "C-m") 'flycheck-mode)
(define-key my/ctrl-q-map (kbd "C-t") 'toggle-cleanup-spaces)
(define-key my/ctrl-q-map (kbd "\\") 'align)
(define-key my/ctrl-q-map (kbd "h") 'windmove-left)
(define-key my/ctrl-q-map (kbd "j") 'windmove-down)
(define-key my/ctrl-q-map (kbd "k") 'windmove-up)
(define-key my/ctrl-q-map (kbd "l") 'windmove-right)
(define-key my/ctrl-q-map (kbd "SPC") 'mark-symbol)

(define-key my/ctrl-q-map (kbd "d") 'double-frame-width)
(define-key my/ctrl-q-map (kbd "h") 'make-frame-width-half)

(define-key my/ctrl-q-map (kbd "C-s") 'goto-scratch-buffer)
(define-key my/ctrl-q-map (kbd "C-b") 'browse-url)
(define-key my/ctrl-q-map (kbd "C-o") 'counsel-rg-org)
(define-key my/ctrl-q-map (kbd "m") 'my-toggle-mode-line)

(define-key my/ctrl-q-map (kbd "C-n") 'neotree-toggle)

(defun goto-scratch-buffer ()
  "Go to the *scratch* buffer."
  (interactive)
  (switch-to-buffer "*scratch*"))

(smartrep-define-key
    global-map "C-q" '(("-" . 'goto-last-change)
                       ("+" . 'goto-last-change-reverse)))

(smartrep-define-key
    global-map "C-c" '(("+" . 'evil-numbers/inc-at-pt)
                       ("-" . 'evil-numbers/dec-at-pt)))

;; (global-set-key (kbd "C-c b") 'helm-descbinds) ;; C-h b でできるので外した。



;; e2wm
(global-set-key (kbd "C-x C-S-d") 'e2wm:dp-array)



(defalias 'exit 'save-buffers-kill-emacs)

(global-set-key (kbd "C-x v b") 'git-branch-next-action)

(global-set-key (kbd "C-x m") 'magit-status)

;; https://www.youtube.com/watch?v=Iqh50fgbIVk
(global-set-key (kbd "\e\ei") (lambda () (interactive) (find-file "~/org/index.org")))
