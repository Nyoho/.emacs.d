;;
;; dump
;; $ emacs --batch -q -l ~/.emacs.d/dump.el
;;
;; load
;; $ emacs --dump-file="/Users/nyoho/.emacs.d/emacs.pdump"

(require 'package)
(custom-set-variables
 '(package-archives '(("org"   . "https://orgmode.org/elpa/")
                      ("melpa" . "https://melpa.org/packages/")
                      ("gnu"   . "https://elpa.gnu.org/packages/"))))
(package-initialize)
(dolist (package '(use-package org company consult vertico
                    magit use-package which-key
                    expand-region))
  (require package))
;; dump image
(dump-emacs-portable "~/.emacs.d/emacs.pdump")
