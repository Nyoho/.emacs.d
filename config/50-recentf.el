;;
;; recentf
;;

(use-package recentf
  :defer t
  :config
  (setq hostname (system-name))
  (if (null hostname)
      (setq hostname "no_host"))
  (setq recentf-save-file (locate-user-emacs-file (concat "recentf" "-" hostname)))
  (setq recentf-max-saved-items 65536) ;;; 最近開いたファイルを保存する数を増やす
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 120)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1)
  )

;; (run-at-time (current-time) 300 'recentf-save-list)
;; でも5分タイマにできる。

;;; ミニバッファの履歴を保存する
(savehist-mode 1)

(use-package recentf-ext
  :after recentf
  :config

  ;; http://stackoverflow.com/questions/22738559/ignore-elpa-files-in-recentf
  (setq recentf-exclude '("/auto-install/" ".recentf" "/repos/" "/elpa/"
                          "\\.mime-example" "\\.ido.last" "COMMIT_EDITMSG"))
  )

;; sync-recentf
;; -> やってない。recentfにホスト名をつけることにした。

(setq inhibit-startup-message t)
(add-hook 'after-init-hook (lambda()
                             (recentf-mode 1)
                             (recentf-open-files)
                             ))
