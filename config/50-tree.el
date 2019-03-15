;;
;; https://www.emacswiki.org/emacs/NeoTree

(use-package neotree
  :bind (([f8] . neotree-toggle))
  :config
  (setq neo-show-hidden-files nil)
  ;; (setq neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$"))
 
  ;; all-the-icons
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))

  (setq neo-create-file-auto-open t)
  (setq neo-persist-show t)
  (setq neo-keymap-style 'concise)
  (setq neo-smart-open t))

