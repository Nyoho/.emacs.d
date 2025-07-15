;; -*- lexical-binding: t; -*-
;;
;; keyfreq.el
;;
;; A statistics for history of commands I execute
;; cf. https://twitter.com/takaxp/status/1067377916722393088
(leaf keyfreq
  :ensure t
  :config
  (keyfreq-mode 1)
  (keyfreq-autosave-mode 1))
