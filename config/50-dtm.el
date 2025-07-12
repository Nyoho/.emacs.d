;; -*- lexical-binding: t; -*-

(leaf mi
  :when (eq system-type 'darwin)
  :doc "DTM on Emacs"
  :config
  (setq mi-use-dls-synth t) ;; OSXの内蔵シンセを使う場合
  )
