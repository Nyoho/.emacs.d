;; you can run like 'emacs -q -l ~/.emacs.d/.debug/{{pkg}}/init.el'
(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (use-package leaf :ensure t)
  (leaf leaf-keywords
    :ensure t
    :init
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))
(leaf leaf-convert
  :doc "Convert many format to leaf format"
  :ensure t)
