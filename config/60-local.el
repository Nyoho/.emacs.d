;;
;; hotentry.el
;;
(leaf hotentry
  :after t
  :disabled t
  :el-get syohex/hotentry.el
  :setq
  ((hotentry:favorites quote ("math" "機械学習" "emacs" "ruby" "python"))
   (hotentry:default-threshold . 2) ;; defaultは 3
   ))

;;
;; 最小の e2wm 設定例
;;
;; (use-package e2wm)
;; (global-set-key (kbd "M-+") 'e2wm:start-management)


;;
;; css-mode customizing
;;
;; imenu を作成
(defun my-css-mode-setup-imenu ()
  (setq imenu-generic-expression
        '(("Selectors" "^[[:blank:]]*\\(.*[^ ]\\) *{" 1)))
  (setq imenu-case-fold-search nil)
  (setq imenu-auto-rescan t)
  (setq imenu-space-replacement " ")
  (imenu-add-menubar-index)
  )
(add-hook 'css-mode-hook 'my-css-mode-setup-imenu)




;;
;; yaml-mode
;;
(leaf yaml-mode
  :ensure t
  :commands yaml-mode
  :mode (("\\.ya?ml$" . yaml-mode)))

;;
;; dash-at-point.el
;;
;; (leaf dash-at-point
;;   :bind
;;   (("C-c d" . dash-at-point)))

;; TODO: なんか候補は出るけどアクションの結果が出ない
(leaf consult-dash
  :ensure t
  :bind
  ("C-c d" . consult-dash)
  ;; :custom ((consult-dash-docsets-path . "~/Library/Application Support/Dash/DocSets/")
  ;;          (consult-dash-common-docsets . '("Javascript" "Rust" "Python_3")))
  :config
  (consult-customize consult-dash :initial (thing-at-point 'symbol))
  :hook ((emacs-lisp-mode-hook . (lambda () (setq-local consult-dash-docsets '("Emacs_Lisp"))))
         (ruby-mode-hook . (lambda () (setq-local consult-dash-docsets '("Ruby_2"))))
         (rust-mode-hook . (lambda () (setq-local consult-dash-docsets '("Rust"))))
         (python-mode-hook . (lambda () (setq-local consult-dash-docsets '("Python_3"))))))

;;
;; popwin.el
;;
;; (use-package popwin)
;; (setq display-buffer-function 'popwin:display-buffer)


;; flymake
(use-package flymake
  :defer t
  :config
  (setq flymake-ruby-executable (shell-command-to-string "rbenv which ruby")))


;;
;; 句読点を統一するコマンド
;; https://bitbucket.org/kai2nenobu/.emacs.d/src/2d2c969a1d4ab3322442718328df81cbcb0f7855/org-init.d/init.org?at=master
(defun my-replace-touten ()
  "読点を．に統一"
  (interactive)
  (save-excursion
    (replace-string "。" "．" nil (point-min) (point-max))))
(defun my-replace-kuten ()
  "句点を，に統一"
  (interactive)
  (save-excursion
    (replace-string "、" "，" nil (point-min) (point-max))))



;; https://qiita.com/styzo/items/4b48ac59d80c16d5adbc
;;; 行間のスペースの設定(バッファローカル)
(defun ls0 (ls)
  (interactive "P")
  (setq line-spacing (if (integerp ls) ls nil)))

(defun ls4 () (interactive) (ls0 4))
(defun ls8 () (interactive) (ls0 8))
(defun ls12 () (interactive) (ls0 12))

(defun ls+ ()
  (interactive)
  (setq line-spacing (+ (or line-spacing 0) 1))
  (redraw-frame))

(defun ls- ()
  (interactive)
  (unless (or (null line-spacing) (<= line-spacing 0))
    (setq line-spacing (- line-spacing 1))
    (redraw-frame)))

;; (global-set-key "\M-]" 'ls+)
;; (global-set-key "\M-[" 'ls-)


(defun open ()
  "Open current buffer for OSX command"
  (interactive)
  (shell-command (concat "open " (buffer-file-name))))


(use-package saveplace
  :defer t
  :config
  (setq-default save-place t)
  )


;; (use-package copy-code
;;   ;; :bind (("C-c cc" . copy-code-as-rtf))
;;   )


(fset 'yes-or-no-p 'y-or-n-p)



(defun my/markdown-mac-grab-safari-link ()
  (interactive)
  (let* ((s (do-applescript
            (concat
             "tell application \"Safari\"\n"
             "	set theUrl to URL of document 1\n"
             "	set theName to the name of the document 1\n"
             "	return \"[\" & theName & \"](\" & theUrl & \")\"\n"
             "end tell\n"))))
    (insert s)))


;; Emacs の見た目だけをモダン化（NS版，26.1）
;; @takaxp
;; https://qiita.com/takaxp/items/6ec37f9717e362bef35f

(set-default 'my-mode-line-format mode-line-format)
(defun my-mode-line-off ()
  "Turn off mode line."
  (setq my-mode-line-format mode-line-format)
  (setq mode-line-format nil))
(defun my-toggle-mode-line ()
  "Toggle mode line."
  (interactive)
  (when mode-line-format
    (setq my-mode-line-format mode-line-format))
  (if mode-line-format
      (setq mode-line-format nil)
    (setq mode-line-format my-mode-line-format)
    (redraw-display))
  (message "%s" (if mode-line-format "( ╹ ◡╹)ｂ ON !" "( ╹ ^╹)ｐ OFF!")))
;; (add-hook 'find-file-hook #'my-mode-line-off)

(setq indicate-buffer-boundaries 'left)


;; C-x C-f が機能アップ。URLも認識。
(ffap-bindings)


(defun double-frame-width ()
  "Double the width of the current frame."
  (interactive)
  (let* ((width (frame-width (selected-frame)))
         (double-width (* 2 width)))
    (set-frame-width (selected-frame) double-width)))

(defun make-frame-width-half ()
  "Make the width of the current frame half."
  (interactive)
  (let* ((width (frame-width (selected-frame)))
         (half-width (/ width 2)))
    (set-frame-width (selected-frame) half-width)))


;;
;; Make scratch buffer 'org-mode'
;;

;; set org-mode
;; "#+begin_src lisp-interaction
;; #+end_src"
