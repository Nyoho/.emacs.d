(when window-system
    ;; the command key as the meta key
    (setq ns-command-modifier (quote meta))
  ;; the alt key as the super key
  (setq ns-alternate-modifier (quote super))

  (define-key global-map [ns-drag-file] 'ns-find-file)

  ;; (mac-auto-ascii-mode 1)

  (setq mac-ime-cursor-type '(bar . 2))

  )
