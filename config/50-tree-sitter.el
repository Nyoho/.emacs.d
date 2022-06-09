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
  :after tree-sitter)
