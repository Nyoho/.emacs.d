;; -*- lexical-binding: t; -*-

(leaf open-junk-file
  :ensure t
  :setq (open-junk-file-format . "~/org/junk/%Y-%m%d-%H%M%S.")
  :bind (("C-x j" . open-junk-file)))
