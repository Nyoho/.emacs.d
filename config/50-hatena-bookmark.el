(use-package helm-hatena-bookmark
  :defer t
  :config
  (defun hatena-bookmark-get-dump ()
    "Get Hatena::Bookmark dump file."
    (interactive)
    (deferred:$
      (deferred:next
        (lambda () (message "Starts updating Hatena bookmark datebase...")))
      (deferred:process "~/bin/anything-hatena-bookmark-get-dump" "Nyoho")
      (deferred:nextc it
        (lambda ()
          (message "Starts updating Hatena bookmark datebase... done!")))
      ))

  (setq helm-hatena-bookmark-username "Nyoho")
  (setq helm-hatena-bookmark-candidate-number-limit 100000)
  (setq helm-hatena-bookmark-interval (* 4 60 60))
  (helm-hatena-bookmark-initialize))
