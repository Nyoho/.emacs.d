;;
;; org-mode
;;

(leaf org-compat
  :after org
  :require t)

(leaf org-multiple-keymap
  :ensure t
  :after org)

(leaf ob-async
  :ensure t
  :setq (ob-async-no-async-languages-alist . '("jupyter-python" "jupyter-julia")))

(leaf ob-jupyter
  :preface
  (defun my/ob-jupyter-auto-start-check ()
      (re-search-forward "#\\+begin_src jupyter-julia" magic-mode-regexp-match-limit t))
  (defun my/ob-jupyter-require ()
    (save-excursion
      (goto-char (point-min))
      (when (re-search-forward "#\\+begin_src *jupyter-julia" nil t)
        (require 'ob-jupyter))))
  :after org
  :hook ((find-file-hook . my/ob-jupyter-require)))

(leaf ob-mermaid
  :ensure t)

(leaf org
  :ensure t
  :mode (("\\.org$" . org-mode)
         ("\\.txt$" . org-mode)
         ("/[rR][eE][aA][dD][mM][eE]$" . org-mode))
  :custom-face
  (org-link . '((((class color) (background light)) :foreground "#0084B8")
                (((class color) (background dark)) :foreground "#3ADCEB")
                (t :weight bold)))
  ;; DeepSkyBlue
  ;; #34D8DE
  ;; #3ADCEB
  :custom
  (org-directory . "~/org")
  (org-html-htmlize-output-type . 'css)
  (org-html-htmlize-font-prefix . "org-")
  (org-refile-targets
   .
   `((,(concat org-directory "/agenda/inbox.org") :maxlevel . 1)
     (,(concat org-directory "/agenda/actions.org") :maxlevel . 1)
     (,(concat org-directory "/agenda/projects.org") :maxlevel . 1)
     (,(concat org-directory "/agenda/someday.org") :level . 1)))
  (org-startup-folded . t)
  :config
  (setq org-startup-truncated nil)
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
  (setq org-default-notes-file "~/org/notes.org")

  (setq org-mobile-inbox-for-pull "~/org/flagged.org")
  (setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
  (setq org-agenda-files '("~/org/agenda/inbox.org"
                           "~/org/agenda/actions.org"
                           "~/org/agenda/projects.org"
                           ))
  (setq org-agenda-span 'week)
  (setq org-hide-leading-stars t)
  ;; (setq org-odd-levels-only t) ;; indent 用途にはなしのほうがいい?
  (setq org-startup-indented t)
  ;; (setq org-adapt-indentation t)

  (setq org-preview-latex-default-process 'dvisvgm)

  (add-to-list 'org-structure-template-alist '("t" . "theorem"))
  (add-to-list 'org-structure-template-alist '("p" . "prop"))

  (leaf org-capture
    :custom
    (org-capture-templates
     .
        '(("t" "Todo" entry
           (file+headline (lambda () (concat org-directory "/agenda/inbox.org")) "Inbox")
           ;; (file (lambda () (concat org-directory "/agenda/inbox.org")))
           "* TODO %^{やること(「〜する」)} %^g\n%?\n")
          ("U" "Note" entry
           (file+headline (lambda () (concat org-directory "/notes.org" "")) "")
           "* %U %^{トピックス} %^g %i%? %a")
        ;; ("b" "Nyotes Page draft" entry (file (choose-new-page "~/org/nyotes/"))
        ;; ("p" "Project Entry" entry (file (choose-project-file))
        ;;  "* TODO %?\n  %i\n  %a\n\n")
        ;; "\n* TODO %?\n")
          )))


  ;; '(("t" "Todo" entry (file+headline "c:/Users/AAA/org/remind.org" "■Capture")
  ;;    "* REMIND %? (wrote on %U)")
  ;;   ("k" "Knowledge" entry (file+headline "c:/Users/AAA/org/knowledge.org" "TOP")
  ;;    "* %?\n  # Wrote on %U"))
  (unbind-key "C-," org-mode-map)
  ;; (require 'org-install) ;; obsoleted

  (delq 'org-gnus org-modules)

  (leaf org-contrib
    :ensure t)
  
  (setq inferior-julia-program-name (car (file-expand-wildcards "/Applications/Julia-*.app/Contents/Resources/julia/bin/julia")))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     (R . t)
     (org . t)
     (emacs-lisp . t)
     (latex . t)
     (ruby . t)
     (haskell . t)
     (julia . t)
     (python . t)
     (perl . t)
     (screen . t)
     (shell . t)
     (sqlite . t)
     (plantuml . t)
     (C . t)
     (ditaa . t)
     (dot . t)
     (mermaid . t)
     ))

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
  
  ;; speed-commands
  ;; headlineの先頭でone key
  (setq org-use-speed-commands t)


  ;; Insert an image from clipboard
  ;; Thanks: https://ladicle.com/post/20200617_130952/
  (defun org-insert-clipboard-image ()
    "Generate png file from a clipboard image and insert a link with caption and org-download tag to current buffer."
    (interactive)
    (let* ((filename
            (concat (file-name-nondirectory (buffer-file-name))
                    "_imgs/"
                    (format-time-string "%Y%m%d_%H%M%S")
                    ".png")))
      (unless (file-exists-p (file-name-directory filename))
        (make-directory (file-name-directory filename)))
      (let* ((output-buffer (generate-new-buffer "*Async Image Generator*"))
             (proc (progn
                     (async-shell-command (concat "pngpastet " filename) output-buffer)
                     (get-buffer-process output-buffer))))
        (if (process-live-p proc)
            (set-process-sentinel proc #'org-display-inline-images)))
      (insert (concat
               ;; DOWNLOADED tag allows you to delete an image by org-download-delete command.
               "#+DOWNLOADED: clipboard @ "
               (format-time-string "%Y-%m-%d %H:%M:%S\n#+CAPTION: \n")
               "[[file:" filename "]]"))))

  ;; Do not pop-up async-image-generator buffer because it's annoying.
  (add-to-list 'display-buffer-alist '("^*Async Image Generator*" . (display-buffer-no-window)))

  (define-key org-mode-map (kbd "C-M-y") 'org-insert-clipboard-image)

  (defun org-image-open-in-finder()
    (interactive)
    (let* ((linkp (bounds-of-thing-at-point 'sentence))
           (link (buffer-substring-no-properties (car linkp) (cdr linkp)))
           (filename (replace-regexp-in-string "\\[\\[\\([^:]*:\\)?\\([^]]+\\)\\].*" "\\2" link)))
      (shell-command (concat "open " (file-name-directory filename)))))

  (define-key org-mode-map (kbd "C-M-l") 'org-image-open-in-finder)



  ;; org-modeのインライン画像のサイズを制限する(最大サイズを指定する) | Misohena Blog
  ;; http://misohena.jp/blog/2020-05-26-limit-maximum-inline-image-size-in-org-mode.html
  (defcustom org-limit-image-size '(0.99 . 0.5) "Maximum image size") ;; integer or float or (width-int-or-float . height-int-or-float)

  (defun org-limit-image-size--get-limit-size (width-p)
    (let ((limit-size (if (numberp org-limit-image-size)
                          org-limit-image-size
                        (if width-p (car org-limit-image-size)
                          (cdr org-limit-image-size)))))
      (if (floatp limit-size)
          (ceiling (* limit-size (if width-p (frame-text-width) (frame-text-height))))
        limit-size)))

  (defvar org-limit-image-size--in-org-display-inline-images nil)

  (defun org-limit-image-size--create-image
      (old-func file-or-data &optional type data-p &rest props)

    (if (and org-limit-image-size--in-org-display-inline-images
             org-limit-image-size
             (null type)
             ;;(image-type-available-p 'imagemagick) ;;Emacs27 support scaling by default?
             (null (plist-get props :width)))
        ;; limit to maximum size
        (apply
         old-func
         file-or-data
         (if (image-type-available-p 'imagemagick) 'imagemagick)
         data-p
         (plist-put
          (plist-put
           (org-plist-delete props :width) ;;remove (:width nil)
           :max-width (org-limit-image-size--get-limit-size t))
          :max-height (org-limit-image-size--get-limit-size nil)))

      ;; default
      (apply old-func file-or-data type data-p props)))

  (defun org-limit-image-size--org-display-inline-images (old-func &rest args)
    (let ((org-limit-image-size--in-org-display-inline-images t))
      (apply old-func args)))

  (defun org-limit-image-size-activate ()
    (interactive)
    (advice-add #'create-image :around #'org-limit-image-size--create-image)
    (advice-add #'org-display-inline-images :around #'org-limit-image-size--org-display-inline-images))

  (defun org-limit-image-size-deactivate ()
    (interactive)
    (advice-remove #'create-image #'org-limit-image-size--create-image)
    (advice-remove #'org-display-inline-images #'org-limit-image-size--org-display-inline-images))

  :hook (org-agenda-mode . hl-line-mode)
  :bind (
         ("C-c a" . org-agenda)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link)
         ("C-c k" . org-multiple-keymap-minor-mode)
         ("C-c m" . org-mark-ring-goto)
         ("C-c /" . org-sparse-tree-indirect-buffer)
         ;; http://blog.livedoor.jp/tek_nishi/archives/2327814.html
         ;; (local-set-key (kbd "C-c C-b") 'org-shiftleft)
         ;; (local-set-key (kbd "C-c C-f") 'org-shiftright)
         ;; (local-set-key (kbd "C-c C-p") 'org-shiftup)
         ;; (local-set-key (kbd "C-c C-n") 'org-shiftdown)
         ))
;; end of leaf org



;; (defun choose-new-page (base-path)
;;   "Finds the project file, creating one if it doesn't already exist"
;;   (let* ((date (org-read-date "" 'totime nil nil (current-time) "")) 
;;          (title (read-string "Post title: "))                       
;;          (url-title (replace-regexp-in-string "\s+" "-" title))       
;;          (path (format "%s/%s/%s/index.org" base-path (format-time-string "%Y/%m/%d") url-title))) 
;;     (make-directory (file-name-directory path) t)
;;     (append-to-file (format "#+begin_html\n---\ntitle: %s\ntags: \ndescription: \n---\n#+end_html\n\n" title) nil path)
;;     path))

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

(setq org-todo-keywords '((sequence "TODO" "WAITING" "|" "DONE")))
;; (setq org-todo-keywords '((sequence "TODO" "APPT" "STARTED" "DONE")))
;; (setq org-todo-keywords '("TODO" "Wait" "DONE")
;;       org-todo-interpretation 'sequence)

(defun gtd ()
  (interactive)
  (find-file "~/org/gtd.org"))
;; (global-set-key (kbd "C-c g") 'gtd)


(unless (setq org-plantuml-jar-path (car (file-expand-wildcards "/usr/local/Cellar/plantuml/*/libexec/plantuml.jar")))
  (setq org-plantuml-jar-path (car (file-expand-wildcards "/opt/homebrew/Cellar/plantuml/*/libexec/plantuml.jar"))))

(leaf ox-latex
  :after org
  :config
  (require 'ox-beamer)
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
                            ("beamer"
                             "\\documentclass[presentation]{beamer}
[PACKAGES]
[EXTRA]
\\usefonttheme{professionalfonts}"
                             ("\\section{%s}" . "\\section*{%s}")
                             ("\\subsection{%s}" . "\\subsection*{%s}")
                             ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
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
        '("uplatex -shell-escape %f"
          "dvipdfmx %b.dvi"))

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

  (setq org-preview-latex-process-alist-nil
        '((dvipng :programs ("latex" "dvipng") :description "dvi > png" :message "you need to install the programs: latex and dvipng." :image-input-type "dvi" :image-output-type "png" :image-size-adjust (1.0 . 1.0) :latex-compiler ("/Library/TeX/texbin/platex -interaction nonstopmode -output-directory %o %f") :image-converter ("/Library/TeX/texbin/dvipng -fg %F -bg %B -D %D -T tight -o %O %f"))
          (dvisvgm :programs ("latex" "dvisvgm") :description "dvi > svg" :message "you need to install the programs: latex and dvisvgm." :use-xcolor t :image-input-type "dvi" :image-output-type "svg" :image-size-adjust (1.7 . 1.5) :latex-compiler ("/Library/TeX/texbin/platex -interaction nonstopmode -output-directory %o %f") :image-converter ("/Library/TeX/texbin/dvisvgm %f -n -b min -c %S -o %O"))
          (imagemagick :programs ("latex" "convert") :description "pdf > png" :message "you need to install the programs: latex and imagemagick." :use-xcolor t :image-input-type "pdf" :image-output-type "png" :image-size-adjust (1.0 . 1.0) :latex-compiler ("/Library/TeX/texbin/lualatex -interaction nonstopmode -output-directory %o %f") :image-converter ("convert -density %D -trim -antialias %f -quality 100 %O")))
        )

  ;; Beamer presentations using the new export engine
  ;; https://orgmode.org/worg/exporters/beamer/ox-beamer.html#export-filters
  (defun my-beamer-bold (contents backend info)
    (when (eq backend 'beamer)
      (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))
  (add-to-list 'org-export-filter-bold-functions 'my-beamer-bold)

  ) ;; end of ox-latex

(defun my-yas-activate-extra-mode-latex ()
  "Activate latex-mode yasnippet"
  (interactive)
  (yas-minor-mode)
  (yas-activate-extra-mode 'latex-mode))

(defun my-company-auctex-prefix (regexp)
  "Returns the prefix for matching given REGEXP not only in latex-mode."
  (when (looking-back regexp)
    (match-string-no-properties 1)))

(defun my-init-company-auctex ()
  "Append LaTeX company backends"
  (interactive)
  (advice-add #'company-auctex-prefix :override #'my-company-auctex-prefix)
  (company-auctex-init))

  ;; or
  ;; (setq-local company-backends
  ;;             (append '((company-auctex-macros
  ;;                        company-auctex-symbols
  ;;                        company-auctex-environments)
  ;;                       company-auctex-bibs
  ;;                       company-auctex-labels)
  ;;                     company-backends)))

(defun setup-my-auto-org-tex ()
  "Start `my-yas-activate-extra-mode-latex', `my-init-company-auctex' and `my-autotex-mode'"
  (interactive)
  (my-yas-activate-extra-mode-latex)
  (my-init-company-auctex)
  (my-autotex-mode))
  
;;
;; org-mode publish
;;
(leaf ox :after org)
(leaf ox-publish :after ox
  :custom
  ((org-publish-project-alist
    .
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
      )))
  :config
  (require 'ox-podcast)
  ;; :publishing-function org-html-publish-to-html 
  ;; org-publish-org-to-html
  (setq org-html-doctype "html5")
  )
(leaf ox-html :after ox)

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

(leaf org-mac-link
  :ensure t
  :after org
  :bind
  ("C-c i" . org-mac-link-get-link))

(leaf org-tempo :after org)

(leaf org-superstar
  :ensure t
  :disabled t
  :after org)

;; http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
(leaf org-bullets
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

  :custom
  (org-bullets-bullet-list .
        '(
          "■" "▶" "▶" "▶" "▶" "▶" "▶"
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
(leaf org-trello
  :after org
  :init
  
  :config
  (setq org-trello-files
        '((expand-file-name "~/org/trello.org")
          (expand-file-name "~/org/trello2.org")))

  (setq org-trello-current-prefix-keybinding "C-c o")
  )


(leaf ox-gfm :after org :ensure t)
(leaf ox-qmd :after org :ensure t)

(leaf org-recent-headings
  :ensure t
  :bind ("C-c f r" . org-recent-headings)
  :config (org-recent-headings-mode))

(leaf org-tree-slide
  :ensure t
  :setq
  (org-tree-slide-slide-in-effect . nil))

(leaf org-present
  :ensure t)

(leaf org-roam
  :ensure t
  :blackout org-roam-mode
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         (:org-mode-map
          ("C-M-i"  . completion-at-point)))
  ;; :hook (after-init-hook)
  :init
  (setq org-roam-v2-ack t)
  :custom `((org-roam-directory . "~/org/r/")
           (org-roam-completion-everywhere . t)
           (org-roam-capture-templates
            . '(("d" "default" plain "%?" :target
                 (file+head "${slug}.org" "#+title: ${title}\n#+date: %U\n") ;; Remove "%<%Y%m%d%H%M%S>-"
                 :unnarrowed t)
                ("p" "public note" plain "%?" :target
                 (file+head "public/${slug}.org" "#+title: ${title}\n#+date: %U\n")
                 :unnarrowed t)
                ("b" "book notes" plain "* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?" :target
                 (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: book\n#+date: %U\n")
                 :unnarrowed t)
                ))
           (org-roam-node-display-template
            .
            ,(concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
           )
  :config
  (org-roam-setup)

  (leaf org-roam-ui
    :ensure t
    :bind (("C-c n u" . org-roam-ui-mode))
    :custom ((org-roam-ui-update-on-save . t))))

(leaf org-roam-dailies
  :after org-roam
  :bind-keymap
  ("C-c n d" . 'org-roam-dailies-map)) ;; Eager macro-expansion failure: (void-variable org-roam-dailies-map)

(leaf org-fragtog
  :doc "使うときは M-x org-fragtog-mode する。"
  :ensure t)

(leaf company-org-block
  :doc "'<'だけでブロックの挿入モードが出現できる。"
  :ensure t
  :custom
  (company-org-block-edit-style . 'inline)
  :hook ((org-mode-hook . (lambda ()
                            (setq-local company-backends (cons 'company-org-block company-backends))
                            (company-mode +1)))))
 
(leaf org-ref
  :ensure t)

(leaf org-roam-bibtex
  :after org-roam
  :ensure t
  :config
  (require 'org-ref))


(leaf org-modern
  :doc "Org-modeの見た目を少しかっこよくする"
  :url "https://github.com/minad/org-modern"
  :ensure t
  :after org
  :hook (org-mode-hook . org-modern-mode))

