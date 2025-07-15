;; -*- lexical-binding: t; -*-

(leaf tree-sitter
  :ensure (t tree-sitter-langs)
  :hook
  (tree-sitter-after-on-hook . tree-sitter-hl-mode)
  :config
  (global-tree-sitter-mode)

  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))

(leaf tree-sitter-langs
  :ensure t
  :after tree-sitter
  :config
  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))

(leaf treesit-auto
  :ensure t
  :custom
  (treesit-auto-install . 'prompt)
  :require t
  :config
  (treesit-auto-add-to-auto-mode-alist 'all))
