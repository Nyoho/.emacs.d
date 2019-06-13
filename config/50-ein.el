;;
;; ein: Jupyter notebook client
;; https://github.com/millejoh/emacs-ipython-notebook
;;

(setq ein:jupyter-default-server-command (concat (getenv "HOME") "/.pyenv/shims/jupyter"))
(setq ein:jupyter-default-notebook-directory (concat (getenv "HOME") "/prog"))
(setq ein:notebook-mode nil) ;; ?
;; then call ein:jupyter-server-start.
