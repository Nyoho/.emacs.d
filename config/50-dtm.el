;; DTM on Emacs
(if ns-p
    (use-package mi
      :defer t
      :config
      (setq mi-use-dls-synth t) ;; OSXの内蔵シンセを使う場合
      )
  )
