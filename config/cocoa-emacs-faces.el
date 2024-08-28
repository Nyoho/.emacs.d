;; -*- lexical-binding: t; -*-
(leaf *macOS-face-customization
  :when window-system
  :config
  :custom-face
  (ns-marked-text-face  . '((t (:background "DeepPink4" :underline t))))
  (ns-working-text-face . '((((background dark)) (:underline "gray80")))))



