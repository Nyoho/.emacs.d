;;
;; shell を利用
;;
(defun skt:shell ()
  (or
   (executable-find "zsh")
   (executable-find "bash")
   (executable-find "cmdproxy")
   (error "can't find 'shell' command in PATH!!")))
;; Shell 名の設定
(setq shell-file-name (skt:shell))
(setenv "SHELL" shell-file-name)
(setq explicit-shell-file-name shell-file-name)

;; terminal を日本語, utf8 でうまく使えるように
(cond
 ((or mac-p ns-p)
  ;; Mac OS X の HFC+ ファイルフォーマットではファイル名は NFD (の様な物)で扱うため以下の設定をする必要がある
  (require 'ucs-normalize)
  (setq file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8-hfs))
 (windows-p
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)
  ;; もしコマンドプロンプトを利用するなら sjisにする
  ;; (setq file-name-coding-system 'sjis)
  ;; (setq locale-coding-system 'sjis)
  )
 (t
  (setq file-name-coding-system 'utf-8)
  (setq locale-coding-system 'utf-8)))

;; Emacs が保持する terminfo を利用する
(setq system-uses-terminfo nil)

;; escape color
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; (require 'multi-term)
;; (setq multi-term-program shell-file-name)

(add-hook 'eshell-mode-hook 'turn-on-eldoc-mode)
(defun eshell/e (arg) (symbol-value (intern-soft arg)))

;; key for term
;; (global-set-key (kbd "C-c t") '(lambda ()
;;                                 (interactive)
;;                                 (term shell-file-name)))

;; (global-set-key (kbd "C-c t") '(lambda ()
;;                                  (interactive)
;;                                  (multi-term)))

;; (global-set-key (kbd "C-c t") '(lambda ()
;;                                 (interactive)
;;                                 (if (get-buffer "*terminal<1>*")
;;                                     (switch-to-buffer "*terminal<1>*")
;;                                 (multi-term))))
