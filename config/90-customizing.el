;;
;; Customized data
;;
;;("View" "%V" TeX-run-discard t t :help "Run Viewer")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t)
 '(ag-reuse-buffers (quote nil))
 '(ag-reuse-window (quote nil))
 '(auto-raise-tool-bar-buttons t t)
 '(auto-resize-tool-bars t t)
 '(blink-cursor-mode nil)
 '(calendar-week-start-day 0)
 '(case-fold-search t)
 '(custom-safe-themes
   '("b7e460a67bcb6cac0a6aadfdc99bdf8bbfca1393da535d4e8945df0648fa95fb"
     "5379937b99998e0510bd37ae072c7f57e26da7a11e9fb7bced8b94ccc766c804"
     "e6ff132edb1bfa0645e2ba032c44ce94a3bd3c15e3929cdf6c049802cf059a2a"
     "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86"
     "912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0"
     "bea5fd3610ed135e6ecc35bf8a9c27277d50336455dbdd2969809f7d7c1f7d79"
     "89fc84ffb9681d9bf8c05a5642dff5f1078fd8b892e974bcfd400f17929cdead"
     "7b4d9b8a6ada8e24ac9eecd057093b0572d7008dbd912328231d0cada776065a"
     "f81a9aabc6a70441e4a742dfd6d10b2bae1088830dc7aba9c9922f4b1bd2ba50"
     "5a0eee1070a4fc64268f008a4c7abfda32d912118e080e18c3c865ef864d1bea"
     "c3e6b52caa77cb09c049d3c973798bc64b5c43cc437d449eacf35b3e776bf85c"
     "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a"
     "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016"
     "557c283f4f9d461f897b8cac5329f1f39fac785aa684b78949ff329c33f947ec"
     "bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f"
     "4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4"
     "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328"
     "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879"
     "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4"
     default))
 '(gud-gdb-command-name "gdb --annotate=1")
 '(js-indent-level 2)
 '(js2-bounce-indent-p t)
 '(large-file-warning-threshold nil)
 '(org-agenda-repeating-timestamp-show-all nil)
 '(org-agenda-restore-windows-after-quit t)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-sorting-strategy
   (quote
    ((agenda time-up priority-down tag-up)
     (todo tag-up))))
 '(org-agenda-start-on-weekday nil)
 '(org-agenda-window-setup (quote other-window))
 '(org-deadline-warning-days 7)
 '(org-export-html-style
   "<link rel=\"stylesheet\" type=\"text/css\" href=\"mystyles.css\">")
 '(org-export-with-toc nil)
 '(org-fast-tag-selection-single-key nil)
 '(org-log-done (quote (done)))
 '(org-reverse-note-order nil)
 '(org-tags-column -78)
 '(org-tags-match-list-sublevels nil)
 '(org-time-stamp-rounding-minutes (quote (0 5)))
 '(org-use-fast-todo-selection t)
 '(org-use-tag-inheritance nil)
 '(robe-completing-read-func (quote helm-robe-completing-read))
 '(session-globals-regexp "-\\(ring\\|history\\|COMMIT_EDITMSG\\)\\'")
 '(session-use-package t nil (session))
 '(yas-trigger-key "TAB"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(markdown-header-face-2 ((t (:inherit org-level-2))))
 '(markdown-header-face-3 ((t (:inherit org-level-3))))
 '(markdown-header-face-4 ((t (:inherit org-level-4))))
 '(markdown-header-face-5 ((t (:inherit org-level-5))))
 '(markdown-header-face-6 ((t (:inherit org-level-6))))
 '(navi2ch-article-header-contents-face ((((class color) (background dark)) (:foreground "CadetBlue2"))))
 '(navi2ch-mona-face ((t (:family "apple-IPAMonaPMincho"))) t))

