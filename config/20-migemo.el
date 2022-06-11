;;
;; for migemo -- migemo 最高
;;
(leaf migemo
  :ensure t
  :when (executable-find "cmigemo")
  
  ;; (setq migemo-use-pattern-alist t)
  ;; (setq migemo-use-frequent-pattern-alist t)
  ;; (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  ;; (setq migemo-options '("-q" "--emacs" "-i" "\g"))
  ;; (setq migemo-dictionary "/usr/local/share/migemo/euc-jp/migemo-dict")
  :custom
  ((migemo-command . "cmigemo")
   (migemo-user-dictionary . nil)
   (migemo-regex-dictionary . nil)
   (migemo-options . '("--quiet" "--nonewline" "--emacs"))
   (migemo-coding-system . 'utf-8-unix))
  :config
  (let ((migemo-dict-candidates
         '("/usr/local/share/migemo/utf-8/migemo-dict"
           "/opt/homebrew/share/migemo/utf-8/migemo-dict")))
    (setq migemo-dictionary (cl-find-if #'file-exists-p migemo-dict-candidates)))
  (load-library "migemo")
  (migemo-init)

  (leaf avy-migemo
    :disabled t
    :after swiper
    :config
    ;; (avy-migemo-mode 1) ;; Emacs headだと動くらしい2019年6月26日(水) https://github.com/abo-abo/swiper/issues/1961
    (leaf avy-migemo-e.g.swiper))
  )
