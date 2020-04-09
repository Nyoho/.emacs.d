;; DTM on Emacs
(if ns-p
    (leaf mi
      :config
      (setq mi-use-dls-synth t) ;; OSXの内蔵シンセを使う場合
      )
  )
