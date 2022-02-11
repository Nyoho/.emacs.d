(setq-default tab-width 4 indent-tabs-mode nil)

;; Emacs講座 -第8回- タブ幅 / マスタカの ChangeLog メモ
;; http://masutaka.net/chalow/2009-07-10-4.html
(defun set-aurora-tab-width (num &optional local redraw)
  "タブ幅をセットします。タブ5とかタブ20も設定できたりします。
localが non-nilの場合は、カレントバッファでのみ有効になります。
redrawが non-nilの場合は、Windowを再描画します。"
  (interactive "nTab Width: ")
  (when local
    (make-local-variable 'tab-width)
    (make-local-variable 'tab-stop-list))
  (setq tab-width num)
  (setq tab-stop-list ())
  (while (<= num 256)
    (setq tab-stop-list `(,@tab-stop-list ,num))
    (setq num (+ num tab-width)))
  (when redraw (redraw-display)) tab-width)

;; (set-aurora-tab-width (setq default-tab-width (setq-default tab-width 8)))

;; タブ文字、全角空白、文末の空白の色付け
;; @see http://www.emacswiki.org/emacs/WhiteSpace
;; @see http://xahlee.org/emacs/whitespace-mode.html
(setq whitespace-style '(spaces tabs newline space-mark tab-mark newline-mark))

;; タブ文字、全角空白、文末の空白の色付け
;; font-lockに対応したモードでしか動作しません
(defface my-mark-tabs
  '((t (:foreground "red" :underline nil)))
  nil :group 'skt)
(defface my-mark-whitespace
  '((t (:background "wetasphalt")))
  nil :group 'skt)
(defface my-mark-lineendspaces
  '((t (:foreground "SteelBlue" :underline t)))
  nil :group 'skt)

(defvar my-mark-tabs 'my-mark-tabs)
(defvar my-mark-whitespace 'my-mark-whitespace)
(defvar my-mark-lineendspaces 'my-mark-lineendspaces)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("\t" 0 my-mark-tabs append)
     ("　" 0 my-mark-whitespace append)
     ;;     ("[ \t]+$" 0 my-mark-lineendspaces append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; 行末の空白を表示
;;(setq-default show-trailing-whitespace t)
;; EOB を表示
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)


;;
;; 編集行を目立たせる（現在行をハイライト表示する）
;;
(defface hlline-face
  '((((class color)
      (background dark))
     ;;(:background "dark state gray"))
     (:background "gray10"
                  :underline "gray24"))
    (((class color)
      (background light))
     (:background "khaki" ;"ForestGreen"
                  :underline nil))
    (t ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(if (not window-system)
    (setq hl-line-face 'underline))
(global-hl-line-mode)

;;; 行の先頭でC-kを一回押すだけで行全体を消去する
(setq kill-whole-line t)

;;; 最終行に必ず一行挿入する
;; (setq require-final-newline t)

;;; バッファの最後でnewlineで新規行を追加するのを禁止する
(setq next-line-add-newlines nil)


;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)



;;
;; uniquify.el
;; ファイル名が重複していたらバッファ名にディレクトリ名を追加する。
(leaf uniquify
  :require t
  :custom
  ;; filename<dir> 形式
  (uniquify-buffer-name-style . 'post-forward-angle-brackets)
  (uniquify-ignore-buffers-re . "*[^*]+*"))


;;
;; for Japanese -- 日本語設定
;;
(use-package ucs-normalize
  :config
  (set-language-environment "Japanese")
  ;;(set-language-environment 'utf-8)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8-unix)

  ;; (if mac-p
  ;;     (set-keyboard-coding-system 'sjis-mac)
  ;;   ;;(set-keyboard-coding-system 'euc-jp-mac)
  ;;   (set-file-name-coding-system 'utf-8)
  ;;   )

  ;; ;;(set-keyboard-coding-system 'utf-8)
  ;; (set-clipboard-coding-system 'sjis-mac)

  (set-keyboard-coding-system 'utf-8)
  ;; (set-file-name-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)

  ;; (modify-category-entry (make-char 'japanese-jisx0213-1) ?j)
  ;; (modify-category-entry (make-char 'japanese-jisx0213-2) ?j)
  ;; (load "subst-jis" )
  ;; ;(eval-after-load "subst-jis" '(load "subst-jisx0213"))
  ;; (load "utf-8") ;; patched file
  ;; (load "utf-16") ;; for safe-charsets
  ;;(require 'utf-8)
  ;;(require 'ucs-tables)

  ;;(setq x-select-request-type 'UTF8_STRING) ; X からのコピペで必要

  ;;(utf-translate-cjk-set-unicode-range `((#x80 . ,(lsh -1 -1))))

  ;;(require 'un-define)
  ;;(require 'un-tools)
  ;;(require 'jisx0213)

  ;;(set-language-environment 'Japanese)
  ;;(set-keyboard-coding-system 'utf-8)

  ;;(set-default-coding-systems 'euc-jp-unix)
  ;;(set-buffer-file-coding-system 'euc-jp-unix)
  ;;(set-terminal-coding-system 'euc-jp-unix)

  ;;(set-keyboard-coding-system 'utf-8)
  ;;(set-terminal-coding-system 'utf-8)

  ;; (setq default-buffer-file-coding-system 'utf-8)

  ;; (set-default-coding-systems 'utf-8)
  ;; (set-buffer-file-coding-system 'utf-8)
  ;; (set-terminal-coding-system 'utf-8)
  ;; (set-keyboard-coding-system 'utf-8)
  ;; (set-file-name-coding-system 'utf-8)
  ;; (set-clipboard-coding-system 'utf-8)

  ;; translation-table-for-input に katakana-jis0201 から mule-unicode への 変換が定義されているためのようです。
  ;; ためしに translation-table-for-input を nil にしたところ、katakana-jis0201 が挿入されました。
  (setq translation-table-for-input nil)
  (setq-default translation-table-for-input nil)
  ;;(utf-translate-cjk-load-tables) ; 変換テーブルの更新
  )



;;
;; revert-mode
;;

;; (setq global-auto-revert-mode t)
(defun dropbox-auto-revert ()
  (when (string-match "Dropbox\\|/org/" buffer-file-name)
    (auto-revert-mode 1)))

;; (add-hook 'find-file-hook 'dropbox-auto-revert)



;; NSPanel, x-popup-hogehoge で panel を出さないで mini buffer に
(setq use-dialog-box nil)

(use-package dimmer
  :defer t
  :config
  (setq dimmer-fraction 0.3)
  (setq dimmer-exclusion-regexp "^\\*helm\\|^\\*my helm\\|^\\*Minibuf\\|^\\*Calendar")
  (dimmer-mode 1)

  (defun dimmer-off () (dimmer-mode -1))
  (defun dimmer-on () (dimmer-mode 1))
  (add-hook 'focus-out-hook #'dimmer-off)
  (add-hook 'focus-in-hook #'dimmer-on))



(use-package help-mode
  :defer t)

;; (global-set-key "\C-h" 'delete-backward-char)
;; (global-set-key [2213] '(lambda()(interactive)(insert 92)))

;; (define-key global-map [2213] nil)
;; (define-key global-map [67111077] nil)
;; (define-key global-map [134219941] nil)
;; (define-key global-map [201328805] nil)
;; (define-key function-key-map [2213] [?\\])
;; (define-key function-key-map [67111077] [?\C-\\])
;; (define-key function-key-map [134219941] [?\M-\\])
;; (define-key function-key-map [201328805] [?\C-\M-\\])

;; (define-key global-map [3420] nil)
;; (define-key global-map [67112284] nil)
;; (define-key global-map [134221148] nil)
;; (define-key global-map [201330012] nil)
;; (define-key function-key-map [3420] [?\\])
;; (define-key function-key-map [67112284] [?\C-\\])
;; (define-key function-key-map [134221148] [?\M-\\])
;; (define-key function-key-map [201330012] [?\C-\M-\\])




;;
;; for ibuffer
;;
(leaf ibuffer
  :bind ("C-x C-b" . ibuffer)
  :config
  (setq ibuffer-formats
        '((mark modified read-only " " (name 50 50) " "  (size 6 -1 :right) " " (mode 16 16 :right) " " filename)
          (mark " " (name 16 -1) " " filename)))

  ;; (define-ibuffer-column name
  ;;   (:name " Name ")
  ;;   ;;navi2ch-article-current-article
  ;;   (if (navi2ch-article-get-current-subject)
  ;;       ;; (format "%s" (cdr (assq 'subject navi2ch-article-current-article)))
  ;;       (format " %s" (navi2ch-article-get-current-subject))
  ;;     (buffer-name)))

  (define-ibuffer-column name
    (:inline t
             ;;:header-mouse-map ibuffer-name-header-map
             :props
             ('mouse-face 'highlight 'keymap ibuffer-name-map
                          'ibuffer-name-column t
                          'help-echo '(if tooltip-mode
                                          "mouse-1: mark this buffer\nmouse-2: select this buffer\nmouse-3: operate on this buffer"
                                        "mouse-1: mark buffer   mouse-2: select buffer   mouse-3: operate"))
             :summarizer
             (lambda (strings)
               (let ((bufs (length strings)))
                 (cond ((zerop bufs) "No buffers")
                       ((= 1 bufs) "1 buffer")
                       (t (format "%s buffers" bufs))))))
    (propertize 
     (if (and (fboundp 'navi2ch-article-get-current-subject)
              (not (string= (navi2ch-article-get-current-subject) "")))
         (format " %s" (navi2ch-article-get-current-subject))
       (buffer-name))
     'font-lock-face (ibuffer-buffer-name-face buffer mark))
    )


  (define-ibuffer-column filename
    (:summarizer
     (lambda (strings)
       (let ((total (length (delete "" strings))))
         (cond ((zerop total) "No files")
               ((= 1 total) "1 file")
               (t (format "%d files" total))))))
                                        ; (if (navi2ch-article-get-current-subject)
                                        ; (format " %s" (navi2ch-article-get-current-subject))
    (let ((directory-abbrev-alist ibuffer-directory-abbrev-alist))
      (abbreviate-file-name
       (or buffer-file-name
           (and (boundp 'dired-directory)
                (if (stringp dired-directory)
                    dired-directory
                  (car dired-directory)))
           "")))
    )
  )
  ;; (ibuffer-define-column
  ;;  ;; ibuffer-formats に追加した文字
  ;;  coding
  ;;  ;; 一行目の文字
  ;;  (:name " coding ")
  ;;  ;; 以下に文字コードを返す関数を書く
  ;;  (if (coding-system-get buffer-file-coding-system 'mime-charset)
  ;;      (format " %s" (coding-system-get buffer-file-coding-system 'mime-charset))
  ;;    " undefined"
  ;;    ))


;;
;; for bs-show
;;
(use-package bs
  :defer t
  :config
  (setq bs-attributes-list
        '((""       1   1 left  bs--get-marked-string)
          ("M"      1   1 left  bs--get-modified-string)
          ("R"      2   2 left  bs--get-readonly-string)
          ("Buffer" bs--get-name-length 20 left  bs--new-get-name)
          (""       1   1 left  " ")
          ("Size"   8   8 right bs--get-size-string)
          (""       1   1 left  " ")
          ("Mode"   16 12 right bs--get-mode-name)
          (""       2   2 left  "  ")
          ("File"   12 12 left  bs--new-get-file-name)
          (""       2   2 left  "  "))
        )

  (defun bs--new-get-name (start-buffer all-buffers)
    "Return name of current buffer for Buffer Selection Menu.
The name of current buffer gets additional text properties
for mouse highlighting.
START-BUFFER is the buffer where we started buffer selection.
ALL-BUFFERS is the list of buffer appearing in Buffer Selection Menu."
    (propertize (if (string= (navi2ch-article-get-current-subject) "")
                    (buffer-name)
                  (format " %s" (navi2ch-article-get-current-subject))
                  )
                'help-echo "mouse-2: select this buffer, mouse-3: select in other frame"
                'mouse-face 'highlight))

  (defun bs--new-get-file-name (start-buffer all-buffers)
    (propertize (if (string= (navi2ch-article-get-current-subject) "")
                    (if (member major-mode '(shell-mode dired-mode))
                        default-directory
                      (or buffer-file-name ""))
                  (cdr (assq 'name navi2ch-article-current-board)))
                'mouse-face 'highlight
                'help-echo "mouse-2: select this buffer, mouse-3: select in other frame")
    )

  (setq bs-configurations
        '(
          ("thread2ch" nil navi2ch-article-get-current-subject nil nil nil)
          ))

  (global-set-key "\C-x\C-b" 'bs-show)

                                        ;(global-set-key [?\C-.] 'bs-cycle-next)
                                        ;(global-set-key [?\C-,] 'bs-cycle-previous)
                                        ;(global-set-key [?\C-c .] 'bs-cycle-next)
                                        ;(global-set-key [?\C-c ,] 'bs-cycle-previous)
  (global-set-key "\C-x\C-j" 'bs-cycle-previous)
  (global-set-key "\C-x\C-k" 'bs-cycle-next)
  )




;;
;; Miscellaneous
;;

(put 'upcase-region 'disabled nil)
;; M-= でいけるのに作ってしまった kill-ring にコピっているやつの長さを数える関数
(defun len-kill-ring ()
  (interactive)
  (message "the length of the kill-ring is %s." (length (car kill-ring)))
  )

(setq lookup-search-agents '(
                             (ndeb "~/src/EDICT")
                             ))
(global-set-key "\C-cL" 'lookup-pattern)



;;
;; for Anthy                                                                                          ;;
                                        ;(push "/usr/share/emacs/site-lisp/anthy/" load-path)
;; (if (eq window-system 'mac)
;;     (progn 
;;       (setq default-input-method "MacOSX")
;;       )
;;   (progn
;;     (load-library "anthy")
;;     (setq default-input-method "japanese-anthy")
;;     (anthy-change-hiragana-map "?" "?")
;;     (anthy-change-hiragana-map "!" "!")
;;     (anthy-change-hiragana-map "1" "1")
;;     (anthy-change-hiragana-map "2" "2")
;;     (anthy-change-hiragana-map "3" "3")
;;     (anthy-change-hiragana-map "4" "4")
;;     (anthy-change-hiragana-map "5" "5")
;;     (anthy-change-hiragana-map "6" "6")
;;     (anthy-change-hiragana-map "7" "7")
;;     (anthy-change-hiragana-map "8" "8")
;;     (anthy-change-hiragana-map "9" "9")
;;     (anthy-change-hiragana-map "0" "0")
;;     (anthy-change-hiragana-map "(" "(")
;;     (anthy-change-hiragana-map ")" ")")
;;     (anthy-change-hiragana-map "#" "#")
;;     (setq anthy-wide-space " ")
;;     )
;; )



;; ファイルの先頭に#!...があるファイルを保存すると実行権をつけます。
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)




;;
;; a spell checker
;;
;;日本語交じりの文書を扱う
(use-package ispell
  :defer t
  :config
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
  (setq ispell-filter-hook-args '("-w -t"))
  ;;latex文書を扱う
  (setq TeX-mode-hook
        (function
         (lambda ()
           (setq ispell-filter-hook "detex"))))
  ;;ispellの代わりにaspell を使う
  (setq-default ispell-program-name "aspell"))



;;
;; pgp, gpg, epa-file
;;
(leaf epa-file
  :when (version< "23" emacs-version)
  :config
  ;; (setq epg-gpg-program "gpg")
  (epa-file-enable))




;;
;; riece -- IRC client
;;
;; (autoload 'riece "riece" "Start Riece" t)



;;
;; twittering-mode "M-x twit"
;;
(use-package twittering-mode
  :defer t
  :config
  (defun twittering-capable-of-encryption-p ()
    (and (or (require 'epa nil t) (require 'alpaca nil t))
         (executable-find "gpg1")))

  (setq twittering-use-master-password t)
  (setq twittering-use-ssl t)
  (setq twittering-icon-mode t)
  (setq twittering-initial-timeline-spec-string
        '(":replies"
          ":favorites"
          ":retweets_of_me"
          ":home"
          ))
  ;; (setq twittering-username "NeXTSTEP2OSX")
  ;; ;;(setq twittering-password "")

  ;; (setq twittering-tmp-dir "/tmp/twitter-buddy-icons"))
)


;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(gud-gdb-command-name "gdb --annotate=1")
;;  '(large-file-warning-threshold nil))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom.
;;   ;; If you edit it by hand, you could mess it up, so be careful.
;;   ;; Your init file should contain only one such instance.
;;   ;; If there is more than one, they won't work right.
;;  '(navi2ch-article-header-contents-face ((((class color) (background dark)) (:foreground "RosyBrown"))))
;;  '(navi2ch-article-header-fusianasan-face ((((class color) (background dark)) (:foreground "LightPink" :underline t)))))

(setq process-coding-system-alist
      (cons '("ruby" utf-8 . utf-8)
            process-coding-system-alist))
;; Beginning of the el4r block:
;; RCtool generated this block automatically. DO NOT MODIFY this block!
                                        ;(add-to-list 'load-path "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/share/emacs/site-lisp")
                                        ;(require 'el4r)
                                        ;(el4r-boot)
;; End of the el4r block.
;; User-setting area is below this line.


;; srcltx
;; (TeX-source-specials-mode 1)

;; (if window-system (server-start))
;; server start for emacs-client
(use-package server
  :config
  (unless (server-running-p)
    (server-start))
  )


;;
;; Macaylay 2
;;
;; (load "~/.emacs-Macaulay2" t)



;;
;; hiki-mode
;;
;; 更新の際に browser を起動したいなら有効に
;; (use-package hiki-mode
;;   :config
;;   ;;(setq hiki-browser-function 'browse-url)
;;   (setq hiki-site-list '(("ワタタツのウィッ記" "https://nyoho.jp/wiki/")
;;                          ))
;;   (setq hiki-browser-function 'browse-url)
;;   (autoload 'hiki-edit "hiki-mode" nil t)
;;   (autoload 'hiki-edit-url "hiki-mode" nil t)
;;   (autoload 'hiki-index "hiki-mode" nil t))




;;
;; mode-compile
;;
;; (autoload 'mode-compile "mode-compile"
;;   "Command to compile current buffer file based on the major mode" t)
;; (global-set-key "\C-c\C-c" 'mode-compile)
;; (autoload 'mode-compile-kill "mode-compile"
;;   "Command to kill a compilation launched by `mode-compile'" t)
;; (global-set-key "\C-ck" 'mode-compile-kill)
;; (global-set-key "\C-cn" 'next-error)	; エラー箇所に飛ぶ



(leaf lacarte
  :when (featurep 'lacarte)
  :require t
  :bind (("M-ESC x" . lacarte-execute-command)
         ("M-`" . lacarte-execute-menu-command)
         ("<f10>" . lacarte-execute-menu-command)))


;;
;; for tramp
;;
(leaf tramp
  :config
  ;; (tramp-default-method "sshx")
  ;; (tramp-remort-sh "/bin/ksh")
  ;; (tramp-remort-sh "/bin/bash")
  )


;;
;; Window 分割
;;
;; (defun other-window-or-split ()
;;   (interactive)
;;   (when (one-window-p)
;;     (split-window)) ;;   (split-window-horizontally))
;;   (other-window 1))
;; (global-set-key (kbd "C-t") 'other-window-or-split)

;; Rubikitch 流分割移動。分割してないときはバッファ切り替えするだけ。
;; http://d.hatena.ne.jp/rubikitch/20111211/smalldisplay
(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer (other-buffer)))

;;; last-buffer
(defvar last-buffer-saved nil)
;; last-bufferで選択しないバッファを設定
(defvar last-buffer-exclude-name-regexp
  (rx (or "*mplayer*" "*Completions*" "*Org Export/Publishing Help*"
          (regexp "^ "))))
(defun record-last-buffer ()
  (when (and (one-window-p)
             (not (eq (window-buffer) (car last-buffer-saved)))
             (not (string-match last-buffer-exclude-name-regexp
                                (buffer-name (window-buffer)))))
    (setq last-buffer-saved
          (cons (window-buffer) (car last-buffer-saved)))))
(add-hook 'window-configuration-change-hook 'record-last-buffer)
(defun switch-to-last-buffer ()
  (interactive)
  (condition-case nil
      (switch-to-buffer (cdr last-buffer-saved))
    (error (switch-to-buffer (other-buffer)))))

(defun switch-to-last-buffer-or-other-window ()
  (interactive)
  (if (one-window-p t)
      (switch-to-last-buffer)
    (other-window 1)))



;;
;; one-key.el
;; ;;
;; (require 'one-key-default) ; one-key.el も一緒に読み込んでくれる
;; (require 'one-key-config) ; one-key.el をより便利にする
;; (one-key-default-setup-keys) ; one-key- で始まるメニュー使える様になる
;; (define-key global-map "\C-x" 'one-key-menu-C-x) ;; C-x にコマンドを定義



;;
;; for view-mode
;;
(setq view-read-only t)
(defvar pager-keybind
  `( ;; vi-like
    ;; ("j" . next-window-line)
    ;; ("k" . previous-window-line)
    ("h" . backward-char)
    ("l" . forward-char)
    ("j" . next-line)
    ("k" . previous-line)
    ;; (";" . gene-word)
    ("b" . scroll-down)
    (" " . scroll-up)
    ("f" . scroll-up)
    ;; w3m-like
    ("m" . gene-word)
    ("i" . win-delete-current-window-and-squeeze)
    ("w" . forward-word)
    ("e" . backward-word)
    ;; ("(" . point-undo)
    ;; (")" . point-redo)
    ;; ("J" . ,(lambda () (interactive) (scroll-up 1)))
    ;; ("K" . ,(lambda () (interactive) (scroll-down 1)))
    ("n" . ,(lambda () (interactive) (scroll-up 1)))
    ("p" . ,(lambda () (interactive) (scroll-down 1)))
    ;; bm-easy
    ("." . bm-toggle)
    ("[" . bm-previous)
    ("]" . bm-next)
    ;; langhelp-like
    ;; ("c" . scroll-other-window-down)
    ;; ("v" . scroll-other-window)
    ))
(defun define-many-keys (keymap key-table &optional includes)
  (let (key cmd)
    (dolist (key-cmd key-table)
      (setq key (car key-cmd)
            cmd (cdr key-cmd))
      (if (or (not includes) (member key includes))
          (define-key keymap key cmd))))
  keymap)

(defun view-mode-hook0 ()
  (define-many-keys view-mode-map pager-keybind)
  ;; (hl-line-mode 1)
  (define-key view-mode-map " " 'scroll-up))
(add-hook 'view-mode-hook 'view-mode-hook0)

;; (defadvice find-file
;;     (around find-file-switch-to-view-file (file &optional wild) activate)
;;   (if (and (not (file-writable-p file))
;;            (not (file-directory-p file)))
;;       (view-file file)
;;     ad-do-it))

(defvar view-mode-force-exit nil)
(defmacro do-not-exit-view-mode-unless-writable-advice (f)
  `(defadvice ,f (around do-not-exit-view-mode-unless-writable activate)
     (if (and (buffer-file-name)
              (not view-mode-force-exit)
              (not (file-writable-p (buffer-file-name))))
         (message "File is unwritable, so stay in view-mode.")
       ad-do-it)))

(do-not-exit-view-mode-unless-writable-advice view-mode-exit)
(do-not-exit-view-mode-unless-writable-advice view-mode-disable)

;; (key-chord-define-global "jk" 'view-mode)
(defalias 'jk 'view-mode)


;;
;; for yank ?
;;
;; (setq x-select-enable-clipboard nil)
;; (setq x-select-enable-primary t)
;; (setq select-active-regions nil)
;; 24.4 でディフォルトになり不要になった。




;;
;; an inertia scroll due to deferred.el
;;
(if (and (not linux-p) nil)
    (progn
      (require 'inertial-scroll)
      (setq inertias-global-minor-mode-map 
            (inertias-define-keymap
             '(
               ("<next>"  . inertias-up)
               ("<prior>" . inertias-down)
               ("C-v"     . inertias-up)
               ("M-v"     . inertias-down)
               ) inertias-prefix-key))
      (inertias-global-minor-mode 1)
      (setq inertias-initial-velocity 380) ; 初速（大きいほど一気にスクロールする）
      (setq inertias-friction 2300)        ; 摩擦抵抗（大きいほどすぐ止まる）
      (setq inertias-rest-coef 0.5)         ; 画面端でのバウンド量（0はバウンドしない。1.0で弾性反発）
      (setq inertias-update-time 0)      ; 画面描画のwait時間（msec）
      ))

;;
;; sudo ext
;;
;; See http://d.hatena.ne.jp/rubikitch/20101018/sudoext
;; M-x sudoedit
;; C-x # (to exit)
(leaf sudo-ext)






;;
;; sequential-command.el
;;

;; multiple-cursors.el に C-a が当たるので外した。<2014-03-18 Tue>
;; (require 'sequential-command-config)
;; (global-set-key "\C-a" 'seq-home)
;; (global-set-key "\C-e" 'seq-end)
;; (when (require 'org nil t)
;;   (define-key org-mode-map "\C-a" 'org-seq-home)
;;   (define-key org-mode-map "\C-e" 'org-seq-end))

;; (define-key esc-map "u" 'seq-upcase-backward-word)
;; (define-key esc-map "c" 'seq-capitalize-backward-word)
;; (define-key esc-map "l" 'seq-downcase-backward-word)


;;
;; M-x install-elisp-from-emacswiki cycle-buffer.el
;;

;; (global-set-key (kbd "M-o") 'cycle-buffer)
;; (global-set-key (kbd "M-O") 'cycle-buffer-backward)



;;
;; diff
;; vc-diff (C-x v =)
(use-package diff-mode
  :defer t
  :config
  ;; 追加された行は緑で表示
  (set-face-attribute 'diff-added nil
                      :foreground "white" :background "dark green")
  ;; 削除された行は赤で表示
  (set-face-attribute 'diff-removed nil
                      :foreground "white" :background "dark red")
  ;; 文字単位での変更箇所は色を反転して強調
  (set-face-attribute 'diff-refine-changed nil
                      :foreground nil :background nil
                      :weight 'bold :inverse-video t)

  ;; diffを表示したらすぐに文字単位での強調表示も行う
  (defun diff-mode-refine-automatically ()
    (diff-auto-refine-mode t))
  (add-hook 'diff-mode-hook 'diff-mode-refine-automatically))





(defun string-word-or-region ()
  (let ((editable (not buffer-read-only))
        (pt (save-excursion (mouse-set-point last-nonmenu-event)))
        beg end)
    (if (and mark-active
             (< = (region-beginning) pt) (<= pt (region-end)) )
        (setq beg (region-beginning)
              end (region-end))
      (save-excursion
        (goto-char pt)
        (backward-char 1)
        (setq end (progn (forward-word) (point)))
        (setq beg (progn (backward-word) (point)))))
    (buffer-substring-no-properties beg end)))

;;
;; From http://www.bach-phys.ritsumei.ac.jp/OSXWS/Mavericks/node59.html
  ;;; text-to-speech by say: word
(defun osxws-speech-word()
  "Speak words."
  (interactive)
  ;; (let* ((str (url-hexify-string (string-word-or-region))))
  (let* ((str (buffer-substring (mark) (point))))
    (process-kill-without-query
     (start-process-shell-command "speech" nil 
                                  "/usr/bin/say " (concat "\"" str "\"" )))))

  ;;; Search marked region by google
(defun osxws-search-google()
  "Search marked region by google"
  (interactive)
  (let* ((str (string-word-or-region)))
    (browse-url
     (concat "https://google.com/search?q=\"" str "\""))))

  ;;; Search marked region by google scholar
(defun osxws-search-googlescholar()
  "Search string by google scholar"
  (interactive)
  (let* ((str (string-word-or-region)))
    (browse-url
     (concat "https://scholar.google.com/scholar?q=\"" str "\""))))

  ;;; "Look up the word by Dictionary.app of Mac OS X"
  ;;; http://sakito.jp/mac/dictionary.html
(defun osxws-lookup-dictionary-osx()
  "Look up the word by Dictionary.app of Mac OS X"
  (interactive)
  (let* ((str (url-hexify-string (string-word-or-region))))
    (browse-url (concat "dict://" str ))))



;; (require 'elscreen)
;; (elscreen-start)

(leaf zoom-window
  :ensure t
  :after t
  :bind (("C-x C-z" . zoom-window-zoom))
  :config
  ;; (setq zoom-window-use-elscreen t) ;; zoom-window-setupの前に設定する必要がある
  (zoom-window-setup))


;; From: http://d.hatena.ne.jp/kaz_yos/20140202/1391362618
;;
;; reveal-in-finder	2014-02-02
;; Original: http://stackoverflow.com/questions/20510333/in-emacs-how-to-show-current-file-in-finder
;; Modified version
(defun reveal-in-finder ()
  (interactive)
  (let ((path (buffer-file-name))
        dir file)
    (if path
        ;; if path has been successfully obtained.
        (progn (setq dir (file-name-directory path))
               (setq file (file-name-nondirectory path)))
      ;; if path is empty, there is no file name. Use the default-directory variable
      (setq dir (expand-file-name default-directory))
      )
    ;; (message (concat "Opening in Finder: " dir file))	; Show the file name
    (reveal-in-finder-1 dir file)      
    ))
;;
(defun reveal-in-finder-1 (dir file)
  (let ((script
         (if file
             (concat
              "set thePath to POSIX file \"" (concat dir file) "\"\n"
              "tell application \"Finder\"\n"
              " set frontmost to true\n"
              " reveal thePath \n"
              "end tell\n"
              )
           (concat
            "set thePath to POSIX file \"" (concat dir) "\"\n"
            "tell application \"Finder\"\n"
            " set frontmost to true\n"
            " reveal thePath \n"
            "end tell\n"))))
    ;; (message script)	; Show the script in the mini-buffer
    (start-process "osascript-getinfo" nil "osascript" "-e" script)
    ))


;; takaxp's mouse click to show the face
(defun my-quickcheck-face-at-point (&optional _)
  (interactive "e")
  (describe-face (face-at-point)))
;; (global-set-key [mouse-1] 'my-quickcheck-face-at-point)




;; Convenient macros for debug

(defmacro po (form)
  `(progn
     (pp ,form)
     nil))

(defmacro p (form)
  `(progn
     (pp (macroexpand-1 ',form))
     nil))

(defmacro pl (form &optional stream)
  `(progn
     (with-temp-buffer
       (insert (prin1-to-string ,form))
       (goto-char (point-min))
       (forward-char)
       (ignore-errors
         (while t (forward-sexp) (insert "\n")))
       (princ (buffer-substring-no-properties (point-min) (point-max))
              (or ,stream standard-output))
       (princ "\n"))
     nil))


(leaf transient-dwim
  :ensure t
  :bind ("M-+" . transient-dwim-dispatch))

(defun deepl-region (beg end)
  (interactive "r")
  (let ((str (buffer-substring beg end)))
    (browse-url
     (concat "https://www.deepl.com/translator#en/ja/" (url-hexify-string str)))))

(defun insert-current-modified-time ()
  (interactive)
  (insert (format-time-string "#+date: <%F %T>" (visited-file-modtime))))


;; https://blog.medalotte.net/archives/1043
(defun my/region-replace (str newstr begin end)
  "指定範囲内で置換を行う"
  (goto-char begin)
  (while (search-forward str end t)
    (replace-match newstr)))
 
(defun my/replace-with-comma-and-period ()
  "選択範囲内の句読点をコンマとピリオドに置き換える"
  (interactive)
  (let ((curpos (point))
        (begin (if (region-active-p)
                   (region-beginning) (point-min)))
        (end (if (region-active-p)
                 (region-end) nil)))
    (my/region-replace "。" "．" begin end)
    (my/region-replace "、" "，" begin end)
    (goto-char curpos)))


(leaf visual-fill-column
  :doc "見た目の幅を制限する"
  :ensure t
  :custom
  (visual-fill-column-center-text . t))
