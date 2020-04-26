;;
;; ein: Jupyter notebook client
;; https://github.com/millejoh/emacs-ipython-notebook
;;

(setq ein:jupyter-default-server-command (expand-file-name "~/.pyenv/shims/jupyter"))
(setq ein:jupyter-default-notebook-directory (expand-file-name "~/prog"))
(setq ein:notebook-mode nil) ;; ?
;; then call ein:jupyter-server-start.
