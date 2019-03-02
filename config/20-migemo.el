;;
;; for migemo -- migemo 最高
;;
;; (if (equal (call-process-shell-command "which cmigemo" nil t) 0)
(if (executable-find "cmigemo")
    (progn
      (require 'migemo)
      ;; (load "migemo.el")
      ;; (setq migemo-use-pattern-alist t)
      ;; (setq migemo-use-frequent-pattern-alist t)
      (setq migemo-command "cmigemo")
      ;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
      ;; (setq migemo-options '("-q" "--emacs" "-i" "\g"))
      ;; (setq migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict")
      (setq migemo-user-dictionary nil)
      (setq migemo-regex-dictionary nil)

      (setq migemo-options '("-q" "--emacs"))
      (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
      (setq migemo-coding-system 'utf-8-unix)
      (load-library "migemo")
      (migemo-init)))
