(leaf helm-hatena-bookmark
  :disabled t
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
  (helm-hatena-bookmark-initialize)
  :pre-setq `((helm-hatena-bookmark-username . "Nyoho")
              (helm-hatena-bookmark-candidate-number-limit . 100000)
              (helm-hatena-bookmark-interval . ,(* 4 60 60))))
;; (* 4 60 60)
(leaf consult-hatena-bookmark
  :bind
  ("C-c h" . consult-hatena-bookmark))
