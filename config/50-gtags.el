;;
;; gtags, GNU Global
;;
(setq gtags-prefix-key "\C-c")
;; (require 'gtags)
;; (require 'anything-gtags)
;; キーバインド
(setq gtags-mode-hook
      '(lambda ()
         (define-key gtags-mode-map "\C-cs" 'gtags-find-symbol)
         (define-key gtags-mode-map "\C-cr" 'gtags-find-rtag)
         (define-key gtags-mode-map "\C-ct" 'gtags-find-tag)
         (define-key gtags-mode-map "\C-cf" 'gtags-parse-file)
         (define-key gtags-mode-map "\C-ch" 'gtags-find-tag-from-here)))
;; gtags-mode を使いたい mode の hook に追加する
(add-hook 'c-mode-common-hook
          '(lambda()
             (gtags-mode 1)))

;; http://shibayu36.hatenablog.com/entry/20101229/1293625186
;; anything-gtags.elを導入してみた - $shibayu36->blog;
(defun anything-gtags-select-all ()
  (interactive)
  (anything-other-buffer
   '(
     anything-c-source-gtags-select
     anything-c-source-imenu)
   "*anything gtags*"))
(defalias 'gt 'anything-gtags-select-all)
(defun anything-gtags-from-here ()
    (interactive)
    (anything
     :sources '(anything-c-source-imenu
                anything-c-source-gtags-select)
     :input (thing-at-point 'symbol)))
(defalias 'gh 'anything-gtags-from-here)
