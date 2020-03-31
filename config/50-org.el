;;
;; org-mode
;;

(use-package org-compat
  :after org
  )

(use-package org-multiple-keymap
  :ensure t
  :after org
  :config
  ;; (setq org-multiple-keymap-minor-mode t)
  )

(leaf org-plus-contrib
  :ensure t
  :after org)

(use-package org
  :defer t
  :mode (("\\.org$" . org-mode) ("\\.txt$" . org-mode) ("/[rR][eE][aA][dD][mM][eE]$" . org-mode))
  :custom
  (org-html-htmlize-output-type 'css)
  (org-html-htmlize-font-prefix "org-")
  :init
  (setq org-startup-truncated nil)
  ;; (setq org-startup-folded nil)
  (setq org-return-follows-link t)
  ;; (setq org-log-done nil)
  (setq org-log-done t)
  (setq org-agenda-include-diary nil)
  (setq org-deadline-warning-days 7)
  (setq org-timeline-show-empty-dates t)
  (setq org-insert-mode-line-in-empty-file t)
  (setq org-hide-emphasis-markers nil) ;; ~foo~ =bar= のときの前後の記号をどうするか
  (setq org-replace-disputed-keys t)
  (setq org-src-fontify-natively t)
  (setq org-directory "~/org/")
  (setq org-default-notes-file "~/org/notes.org")

  (setq org-mobile-inbox-for-pull "~/org/flagged.org")
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
  (setq org-agenda-files (quote ("~/org/agenda/inbox.org"
                                 "~/org/test.org"
                                 "~/org/design.org")
                                ))
  (setq org-agenda-ndays 7)
  (setq org-hide-leading-stars t)
  ;; (setq org-odd-levels-only t) ;; indent 用途にはなしのほうがいい?
  (setq org-startup-indented t)
  ;; (setq org-adapt-indentation t)

  ;; (setq org-remember-templates
  ;;       '(
  ;;         ("Todo" ?t "* TODO %^{やること(「〜する」)} %^g\n%?\n  Added: %U" "~/org/gtd.org" "Inbox")
  ;;         ("Note" ?n "\n* %U %^{トピックス} %^g \n%i%?\n %a" "~/org/notes.org")
  ;;         ))

  ;; org-capture 
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline (lambda () (concat org-directory "agenda/inbox.org")) "Inbox")
           "* TODO %^{やること(「〜する」)} %^g
%?
  Added: %n")
          ("U" "Note" entry
           (file+headline (lambda () (concat org-directory "notes.org" "")) "")
           "* %U %^{トピックス} %^g %i%? %a")
        ;; ("b" "Nyotes Page draft" entry (file (choose-new-page "~/org/nyotes/"))
        ;; ("p" "Project Entry" entry (file (choose-project-file))
        ;;  "* TODO %?\n  %i\n  %a\n\n")
        ;; "\n* TODO %?\n")
          ))


  ;; '(("t" "Todo" entry (file+headline "c:/Users/AAA/org/remind.org" "■Capture")
  ;;    "* REMIND %? (wrote on %U)")
  ;;   ("k" "Knowledge" entry (file+headline "c:/Users/AAA/org/knowledge.org" "TOP")
  ;;    "* %?\n  # Wrote on %U"))
  (defalias 'cp 'org-capture)

  :config
  (unbind-key "C-," org-mode-map)
  ;; (require 'org-install) ;; obsoleted

  (delq 'org-gnus org-modules)

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (R . t)
     (org . t)
     (emacs-lisp . t)
     (latex . t)
     (ruby . t)
     (haskell . t)
     (python . t)
     (perl . t)
     (screen . t)
     (shell . t)
     (sqlite . t)
     (plantuml . t)
     (C . t)
     (ditaa . t)
     (dot . t)))

  ;; (add-to-list 'load-path "~/.emacs.d/el-get/org-mode/contrib/lisp" t)

  ;; These lines only if org-mode is not part of the X/Emacs distribution.
  ;; (autoload 'org-mode "org" "Org mode" t)
  ;; (autoload 'org-diary "org" "Diary entries from Org mode")
  ;; (autoload 'org-agenda "org" "Multi-file agenda from Org mode" t)
  ;; (autoload 'org-store-link "org" "Store a link to the current location" t)
  ;; (autoload 'orgtbl-mode "org" "Org tables as a minor mode" t)
  ;; (autoload 'turn-on-orgtbl "org" "Org tables as a minor mode")

  ;; http://rubikitch.com/2014/10/10/org-sparse-tree-indirect-buffer/
  (defun org-sparse-tree-indirect-buffer (arg)
    (interactive "P")
    (let ((ibuf (switch-to-buffer (org-get-indirect-buffer))))
      (condition-case _
          (org-sparse-tree arg)
        (quit (kill-buffer ibuf)))))

  
  ;; ちょっと重いので中止 -> やっぱり再開
  (smartrep-define-key 
      org-mode-map "C-c" '(("C-n" . (lambda () 
                                      (outline-next-visible-heading 1)))
                           ("C-p" . (lambda ()
                                      (outline-previous-visible-heading 1)))))
  
  :hook (org-agenda-mode . hl-line-mode)
  :bind (
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link)
         ("C-c i" . org-mac-grab-link)
         ("C-c k" . org-multiple-keymap-minor-mode)
         ("C-c m" . org-mark-ring-goto)
         ("C-c /" . org-sparse-tree-indirect-buffer)
         ;; http://blog.livedoor.jp/tek_nishi/archives/2327814.html
         ;; (local-set-key (kbd "C-c C-b") 'org-shiftleft)
         ;; (local-set-key (kbd "C-c C-f") 'org-shiftright)
         ;; (local-set-key (kbd "C-c C-p") 'org-shiftup)
         ;; (local-set-key (kbd "C-c C-n") 'org-shiftdown)
   )
  ;; (define-key global-map (kbd "C-c l") 'org-store-link)
  ;; (define-key global-map (kbd "C-c a") 'org-agenda)
  )



;; (defun choose-new-page (base-path)
;;   "Finds the project file, creating one if it doesn't already exist"
;;   (let* ((date (org-read-date "" 'totime nil nil (current-time) "")) 
;;          (title (read-string "Post title: "))                       
;;          (url-title (replace-regexp-in-string "\s+" "-" title))       
;;          (path (format "%s/%s/%s/index.org" base-path (format-time-string "%Y/%m/%d") url-title))) 
;;     (make-directory (file-name-directory path) t)
;;     (append-to-file (format "#+begin_html\n---\ntitle: %s\ntags: \ndescription: \n---\n#+end_html\n\n" title) nil path)
;;     path))

;; (define-key global-map [f7] 'gtd)
;; (define-key global-map [f8] 'remember)
;; (define-key global-map [f9] 'remember-region)

(setq org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (htmlize-output-type 'css)))

(setq org-agenda-custom-commands
      '(
        ("p" "Projects"
         ((tags "PROJECT")))
        ("h" "Office and Home Lists"
         ((agenda)
          (tags-todo "office")
          (tags-todo "home")
          (tags-todo "web")
          (tags-todo "call")
          ))

        ("d" "Daily Action List"
         (
          (agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))))

;; (setq org-todo-keywords '((sequence "TODO" "APPT" "STARTED" "DONE")))
;; (setq org-todo-keywords '("TODO" "Wait" "DONE")
;;       org-todo-interpretation 'sequence)

(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org"))
;; (global-set-key (kbd "C-c g") 'gtd)





(setq org-plantuml-jar-path (car (file-expand-wildcards "/usr/local/Cellar/plantuml/*/libexec/plantuml.jar")))

(use-package ox-latex
  :after org
  :defer t
  :config
  (setq org-latex-default-class "jsarticle")
  (setq org-latex-classes '(("jsarticle"
                             "\\documentclass{jsarticle}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{url}
\\usepackage{atbegshi}
\\AtBeginShipoutFirst{\\special{pdf:tounicode EUC-UCS2}}
\\usepackage[dvipdfmx,setpagesize=false]{hyperref}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ("jsbook"
                             "\\documentclass{jsbook}
\\usepackage[dvipdfmx]{graphicx}
\\usepackage{url}
\\usepackage{atbegshi}
\\AtBeginShipoutFirst{\\special{pdf:tounicode EUC-UCS2}}
\\usepackage[dvipdfmx,setpagesize=false]{hyperref}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
                             ("\\chapter{%s}" . "\\chapter*{%s}")
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                             ("\\paragraph{%s}" . "\\paragraph*{%s}")
                             ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
                            ))
  (setq org-latex-pdf-process
        '("pdflatex %f" "pdflatex %f" "pdflatex %f"))

  ;; TODO: C-c C-e ll では、Emacsで行った標準のTeX設定へ飛んでいるが、'.org' までファイル名が含まれてしまっていて存在しなくなっている。

  (plist-put org-format-latex-options :scale 1.6)
  ;; (setq org-format-latex-options
  ;;       '(:foreground default
  ;;                     :background default
  ;;                     :scale 1.0 :html-foreground "Black" :html-background "Transparent"  :html-scale 2.0
  ;;                     :scale 2.0
  ;;                     ))
  ;; (setq org-format-latex-options
  ;;       '(:foreground default :background default :scale 2.0 :html-foreground "Black" :html-background "Transparent" :html-scale 2.0 :matchers ("begin" "$1" "$" "$$" "\\(" "\\[")))

  (setq org-preview-latex-process-alist
        '((dvipng :programs ("latex" "dvipng") :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust (1.0 . 1.0) :latex-compiler ("/Library/TeX/texbin/platex -interaction nonstopmode -output-directory %o %f") :image-converter ("/Library/TeX/texbin/dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
          (dvisvgm :programs ("latex" "dvisvgm") :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust (1.7 . 1.5) :latex-compiler ("/Library/TeX/texbin/platex -interaction nonstopmode -output-directory %o %f") :image-converter ("/Library/TeX/texbin/dvisvgm %f -n -b min -c %S -o %O"))
          (imagemagick :programs ("latex" "convert") :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust (1.0 . 1.0) :latex-compiler ("/Library/TeX/texbin/lualatex -interaction nonstopmode -output-directory %o %f") :image-converter ("convert -density %D -trim -antialias %f -quality 100 %O")))
        )
  )

;;
;; org-mode publish
;;
(use-package ox :after org)
(use-package ox-publish :after ox
  :config
  (setq org-publish-project-alist
        '(
          ("nyotes"
           :base-directory "~/org/public/"
           :base-extension "org"
           :publishing-directory "~/Dropbox/nyotes_site/pages/"
           :publishing-function org-html-publish-to-html
           :recursive t
           :site-root "http://nyotes.nyoho.jp"
           :exclude "^blog\\|^bitacora"
           :section-numbers nil
           :headline-levels 4
           :html-extension "html"
           :table-of-contents nil
           :auto-index nil
           :auto-preamble nil
           :body-only t
           :auto-postamble nil)
          ("podcast"
           :base-directory "~/org/podcast/"
           :base-extension "org"
           :publishing-directory "~/Dropbox/podcast-episodes/"
           :publishing-function org-podcast-publish-to-txt
           :recursive t)
          ))
  (use-package ox-podcast :after ox)
  ;; :publishing-function org-html-publish-to-html 
  ;; org-publish-org-to-html
  (setq org-html-doctype "html5")
  )
(use-package ox-html :after ox)

;;
;;
;;

;; (load "url-from-safari.el")
;; (defun insert-org-link-from-safari ()
;;   (interactive)
;;   (insert (osx-get-org-link-from-safari)))

;; (global-set-key (kbd "C-c ol") 'insert-org-link-from-safari) ;; org-link
;; 実は org-mode の contrib にあった。下を使う。

;;
;; org-mac-link-grabber.el (contrib/ にある)
;;
;; (use-package org-mac-link-grabber)
;; M-x omlg-grab-link でいろいろできます。
;; (global-set-key (kbd "C-c ol") 'omlg-grab-link)

(use-package org-mac-link :after org)

(use-package org-tempo :after org)

;; http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
(use-package org-bullets
  :ensure t
  :after org
  :if (memq window-system '(mac ns))
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  
  ;; better headers
  (let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                               ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                               ((x-list-fonts "Verdana")         '(:font "Verdana"))
                               ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                               (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    ;; (custom-theme-set-faces 'user
    ;;                         `(org-level-8 ((t (,@headline ,@variable-tuple))))
    ;;                         `(org-level-7 ((t (,@headline ,@variable-tuple))))
    ;;                         `(org-level-6 ((t (,@headline ,@variable-tuple))))
    ;;                         `(org-level-5 ((t (,@headline ,@variable-tuple))))
    ;;                         `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.2))))
    ;;                         `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
    ;;                         `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.3))))
    ;;                         `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.5))))
    ;;                         `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil)))))
    )

  (setq org-bullets-bullet-list
        '(
          "■" "▶" "▽" "▲" "△" "▼" "◎"
          "●" "●" "●" "●" "●" "●" "●" 
          "壹" "貳" "參" "肆" "伍" "陸" "漆"
          "✿" "☯"
          ;; 気分によって変える記号たち
          ;; "►"
          ;; "◖"
          ;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
          ;; ◉ ○ ✸ ✿
          ;; ► • ★ ▸ 🔘⚪️🔹
          ))
  )

;;
;; org-trello
;;
(use-package org-trello
  :after org
  :defer t
  :init
  
  :config
  (setq org-trello-files
        '((concat (getenv "HOME") "/org/trello.org")
          (concat (getenv "HOME") "/org/trello2.org")))

  (setq org-trello-current-prefix-keybinding "C-c o")
  )


(use-package ox-gfm :after ox :ensure t)
(use-package ox-qmd :after ox :ensure t)

(use-package org-seek
  :after org
  :defer t
  :ensure t
  :commands (org-seek-string org-seek-regexp org-seek-headlines)
  :config
  (setq org-seek-search-tool 'ripgrep)
  )
