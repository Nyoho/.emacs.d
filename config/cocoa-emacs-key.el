(leaf cocoa-key-setting
  :when window-system
  :config
  ;; the command key as the meta key
  (setq ns-command-modifier 'meta)
  ;; the alt key as the super key
  (setq ns-alternate-modifier 'super)

  (define-key global-map [ns-drag-file] 'ns-find-file)
  ;; (mac-auto-ascii-mode 1)
  (setq mac-ime-cursor-type '(bar . 2)))
