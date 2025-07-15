;; -*- lexical-binding: t; -*-
;;
;; for TeX, LaTeX, pLaTeX2e, ...
;;

;; (setq auto-mode-alist (cons (cons ".tex$" 'yatex-mode) auto-mode-alist))
;; (autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; (setq load-path (cons (expand-file-name "/usr/share/emacs/site-lisp/yatex") load-path))
;; (setq YaTeX-close-paren-always nil)
;; (setq yatex-modify-mode t)

;; (setq tex-command "platex"
;;       dvi2-command "/Applications/MxDvi.app/Contents/MacOS/Mxdvi"       dviprint-command-format "dvips %s | lpr"
;;       YaTeX-kanji-code 2 ; (1 JIS, 2 SJIS, 3 EUC)
;;       YaTeX-use-AMS-LaTeX t ; AMS-LaTeX 
;;       section-name "documentclass"
;;       makeindex-command "mendex"
;;       YaTeX-latex-message-code 'sjis-mac  
;; )


;; (with-eval-after-load "LaTeX"
;;   (define-key LaTeX-mode-map (kbd "//") 'sesame-slash-dwim))
(defun sesame-slash-dwim (arg)
  "Insert the character you type.
With ARG, insert LaTeX fraction code.  This is supposed to bind
to [/]."
  (interactive "P")
  ;; (if arg
  (let* ((bounds (bounds-of-thing-at-point 'sexp))
         (start (car bounds))
         (end (cdr bounds))
         (value-selection (buffer-substring-no-properties start end)))
    (delete-region start end)
    (insert (format "\\frac{%s}{}" value-selection))
    (left-char 1))
  ;;(call-interactively 'self-insert-command)
  ;; )
  )

;;
;; AUCTeX
;;
(leaf auctex
  :ensure t
  :custom ((TeX-default-mode . 'japanese-latex-mode)
           (japanese-LaTeX-default-style . "jsarticle")
           ;; (japanese-TeX-command-default . "pTeX")
           (japanese-LaTeX-command-default . "pLaTeX")
           (japanese-LaTeX-command-default . "pdfpLaTeX")
           (preview-image-type . 'dvipng) ;; preview-latex で dvipng を使う
           (TeX-output-view-style . '()) ;; View open hogehoge.pdf 
           )
  :config
  (leaf preview-latex)
  (leaf company-auctex
    :ensure t
    :after tex-mode
    :init (company-auctex-init))
  (leaf company-reftex :ensure t)
  (add-to-list 'TeX-output-view-style
               '("^dvi$" "." "open %s.pdf"))
  )


;; View は、dvipdfmx で、pdf file を作って、Adobe Reader で閲覧
;;'("^dvi$" "." "dvipdfmx %dS %d && open %s.pdf"))

;; ;(require 'tex-site)
;; (setq auto-mode-alist
;;       (append '(
;; 		("\\.tex$" . japanese-latex-mode)
;; 		("\\.ltx$" . japanese-latex-mode)
;; 		)
;; 	      auto-mode-alist))
;; (setq japanese-LaTeX-default-style "jarticle")
;; (setq kinsoku-limit 10)
;; ;(setq TeX-view-style
;; ;      '(
;; ;	("." "/Application/Mxdvi.app/Contents/MacOS/Mxdvi %d")
;; ;	))

(setq TeX-view-style
      '(("^ohp$" "/Application/Mxdvi.app/Contents/MacOS/Mxdvi %d")
        ("." "/Application/Mxdvi.app/Contents/MacOS/Mxdvi %d")))
(setq TeX-brace-indent-level 0)

(setq japanese-LaTeX-view-style
      '(("^ohp$" "/Application/Mxdvi.app/Contents/MacOS/Mxdvi %d")
        ("." "/Application/Mxdvi.app/Contents/MacOS/Mxdvi %d")))

(setq TeX-view-style
      '(
        ("." "/Users/sakito/opt/mxdvi/Mxdvi.app/Contents/MacOS/Mxdvi %d")
        ))

;; (setq pLaTeX-command-list
;;       (list
;;        (list "pLaTeX" "/usr/local/bin/platex '\\nonstopmode\\input{%t}'"
;; 	     'pLaTeX-run-command nil t)
;;        )
;;       )
;; ;(setq TeX-command-list
;; ;      (append (list
;; ;	       (list "pLaTeX" "platex '\\nonstopmode\\input{%t}'"
;; ;		     'TeX-run-command nil t)
;; ;	       )
;; ;	      TeX-command-list))


;; ;(setq TeX-view-style
;; ;      '(
;; ;	("." "/Users/sakito/opt/mxdvi/Mxdvi.app/Contents/MacOS/Mxdvi %d")
;; ;	))

;; (setq load-path (cons (expand-file-name "/usr/share/emacs/site-lisp/auctex") load-path))
;; 					;(setq auto-mode-alist
;; 					;      (cons (cons "\\.tex$" 'tex-site) auto-mode-alist))
;; (setq TeX-default-mode 'japanese-latex-mode)
;; (setq TeX-command-default "pLaTeX")
;; (setq japanese-TeX-command-default "pTeX")
;; (setq japanese-LaTeX-command-default "pLaTeX")
;; 					;(setq japanese-LaTeX-default-style "jarticle")



(setq TeX-engine-alist '((ptex "pTeX" "eptex" "platex" "eptex")
                         (uptex "upTeX" "euptex" "uplatex" "euptex")))
(setq TeX-engine 'ptex)
(setq TeX-view-program-list '(("pxdvi" "/Library/TeX/texbin/pxdvi -nofork -watchfile 1 -editor \"emacsclient --no-wait +%%l %%f\" %d -sourceposition %n:%b")
                              ("PictPrinter" "/usr/bin/open -a PictPrinter.app %d")
                              ("Mxdvi" "/usr/bin/open -a Mxdvi.app %d")
                              ("Preview" "/usr/bin/open -a Preview.app %o")
                              ("TeXShop" "/usr/bin/open -a TeXShop.app %o")
                              ("TeXworks" "/usr/bin/open -a TeXworks.app %o")
                              ("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %o %b")
                              ("MuPDF" "/usr/local/bin/mupdf %o")
                              ("pdfopen" "/usr/bin/open -a \"Adobe Reader.app\" %o")))
(setq TeX-view-program-selection '((output-dvi "pxdvi")
                                   (output-pdf "Preview")))

(defun platex-kanji-option ()
  (cond ((eq buffer-file-coding-system 'utf-8-unix) "utf8")
        ((eq buffer-file-coding-system 'japanese-shift-jis-unix) "sjis")))

(setq TeX-PDF-mode nil)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(defun add-my-latex-environments ()
  (LaTeX-add-environments
   '("definition" LaTeX-env-label)
   '("theorem" LaTeX-env-label)
   '("example" LaTeX-env-label)
   '("remark" LaTeX-env-label)
   '("lemma" LaTeX-env-label)
   '("proposition" LaTeX-env-label)))
(add-hook 'LaTeX-mode-hook 'add-my-latex-environments)

(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)

(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'my-TeX-command-list-adder)
(defun my-TeX-command-list-adder ()
  (dolist (item
           '(("pdfpLaTeX" "platex -synctex=1 %t && dvipdfmx %d"
              ;; '("pdfpLaTeX" "platex -synctex=1 %t && dvipdfmx -f ~/tex/texinputs/hiragino-embed %d"
              ;; '("pdfpLaTeX" "platex -kanji=sjis -synctex=1 %t && dvipdfmx -f ~/tex/texinputs/hiragino-embed %d"
              ;; /usr/local/texlive/texmf-local/fonts/map/dvipdfm/hiragino-embed
              TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX and dvipdfmx")
             ("Nonstop-pdfpLaTeX" "platex -synctex=1 -interaction=nonstopmode %t && dvipdfmx %d || say エラーですけど"
              TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX and dvipdfmx")
             ("PythonTeX-dvipdfmx" "pythontex %t && platex -synctex=1 -interaction=nonstopmode %t pythontex %t && platex -synctex=1 -interaction=nonstopmode %t && dvipdfmx %d || say エラーですよ"
              TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, pythontex, platex, and dvipdfmx")
             ("only-PythonTeX" "pythontex %t"
              TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, pythontex, platex, and dvipdfmx")
             ("pdfpLaTeX2" "platex -synctex=1 %t && dvips -Ppdf -t a4 -z -f %d | convbkmk -g > %f && /usr/local/bin/ps2pdf %f"
              TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX, dvips, and ps2pdf")
             ("pdfupLaTeX" "uplatex -synctex=1 %t && dvipdfmx %d"
              TeX-run-TeX nil (latex-mode) :help "Run e-upLaTeX and dvipdfmx")
             ("Latexmk" "latexmk -pdf %s"
              TeX-run-command nil t :help "Run Latexmk on file")
             ("XeLaTeX" "xelatex -synctex=1 %t"
              TeX-run-TeX nil (latex-mode) :help "Run XeLaTeX")
             ("pBibTeX" "pbibtex %s"
              TeX-run-BibTeX nil t :help "Run pBibTeX")
             ("upBibTeX" "upbibtex %s"
              TeX-run-BibTeX nil t :help "Run upBibTeX")
             ("Mendex" "mendex %s"
              TeX-run-command nil t :help "Create index file with mendex")
             ("Preview" "/usr/bin/open -a Preview.app %s.pdf"
              TeX-run-discard-or-function t t :help "Run Preview")
             ("TeXShop" "/usr/bin/open -a TeXShop.app %s.pdf"
              TeX-run-discard-or-function t t :help "Run TeXShop")
             ("TeXworks" "/usr/bin/open -a TeXworks.app %s.pdf"
              TeX-run-discard-or-function t t :help "Run TeXworks")
             ("View" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %s.pdf %b"
              TeX-run-discard-or-function t t :help "Forward search with Skim")
             ("pdfopen" "/usr/bin/open -a \"Adobe Reader.app\" %s.pdf"
              TeX-run-discard-or-function t t :help "Run Adobe Reader")
             ))
    (add-to-list 'TeX-command-list item)))

;; (setq TeX-parse-self t)
;; (setq TeX-auto-save t)

;;
;; RefTeX (AUCTeX)
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


(leaf tex
  :after t
  :config
  (TeX-add-style-hook
   "latex"
   (lambda ()
     (LaTeX-add-environments '("document" LaTeX-env-document)
                             '("enumerate" LaTeX-env-item)
                             '("itemize" LaTeX-env-item)
                             '("list" LaTeX-env-list)))))

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)


;;
;; AUCTeX auto-compile
;;

;; Emacs Lisp TIPS by Prof. Seiji Zenitani
;; https://sci.nao.ac.jp/MEMBER/zenitani/elisp-j.html#auto-tex
;;
;; automatically run background TeX process
;; AUCTeX の設定と便利な機能 | Amrta
;; https://skalldan.wordpress.com/2011/07/20/auctex-%e3%81%ae%e8%a8%ad%e5%ae%9a%e3%81%a8%e4%be%bf%e5%88%a9%e3%81%aa%e6%a9%9f%e8%83%bd/
(defun my-autotex ()
  (interactive)
  (require 'deferred)
  (cond
   ((string-match "\\.tex$" (buffer-file-name))
    (progn
    (let ((buf (get-buffer "*Background TeX proccess*")))
      (if (bufferp buf) (kill-buffer buf)) ) ;; flush previous log
    (deferred:$
      (deferred:next
        (lambda () (message "Starts auto-TeXing...")))
      (deferred:nextc it
        (lambda ()
          (if (and (boundp 'file-local-variables-alist)
                   (assoc 'pythontex-mode file-local-variables-alist))
              (TeX-command "PythonTeX-dvipdfmx" 'TeX-master-file nil)
            (TeX-command "Nonstop-pdfpLaTeX" 'TeX-master-file nil))))
      (deferred:nextc it
        (lambda ()
          (message "Starts auto-TeXing... done!")))
      (deferred:error it
        (lambda (err)
          (message "Starts auto-TeXing... An error occured.")))
      )
    ;; (require 'smart-compile) ;; for smart-compile-string
    ;; (start-process-shell-command
    ;;  "Background TeX" "*Background TeX proccess*"
    ;;  (if (and (boundp 'TeX-PDF-mode) TeX-PDF-mode)
    ;;      (smart-compile-string "pdflatex -interaction=nonstopmode %f || SayKana エラーです") ; PDFTeX
    ;;    (smart-compile-string "latexmk %f || growlnotify -a Emacs.app -t \"Oops!\" -m \"エラーが起こりました。\"") ; pTeX
    ;;    )
    ))
   ((string-match "\\.org$" (buffer-file-name))
    (progn
      (deferred:$
        (deferred:next
          (lambda () (message "Starts auto-TeXing...")))
        (deferred:nextc it
          (lambda ()
            ;; TODO: Select beamer or usual latex automatically
            (org-beamer-export-to-latex)
            (unless (get-buffer-process (my-autotex-buffer-name))
              (my-latexmk-start))
            ))
        ;; (deferred:nextc it
        ;;   (lambda ()
        ;;     (let* ((file-name (file-name-sans-extension buffer-file-name)))
        ;;       (leaf smart-compile :ensure t :require t)
        ;;       (start-process-shell-command
        ;;        "Background TeX" "*Background TeX proccess*"
        ;;        (smart-compile-string (format "uplatex -shell-escape %s && dvipdfmx %s" file-name file-name))
        ;;        )
        ;;        )
        ;;     ))
        (deferred:nextc it
          (lambda ()
            (message "Starts auto-TeXing... done!")))
        (deferred:error it
          (lambda (err)
            (message "Starts auto-TeXing... An error occured.")))
      ))
   )))

(defun my-autotex-buffer-name ()
  (format "*latexmk from org [%s]*" (buffer-file-name)))

(defun my-latexmk-start ()
  (interactive)
  (let (dir buf)
    (setq file (file-name-sans-extension (file-name-nondirectory (buffer-file-name))))
    (setq buf (get-buffer-create (my-autotex-buffer-name)))
    (with-current-buffer buf
      (erase-buffer))
    (start-process "latexmk from Org" (my-autotex-buffer-name) "latexmk" "-pvc" file)
    ;; (call-process "latexmk" nil buf nil "-pvc" file)
    ;;(display-buffer buf)
    ))

;; wrapper
(define-minor-mode my-autotex-mode
  "My autotex mode."
  :global nil
  :lighter " Auto"
  (if my-autotex-mode
      (add-hook 'after-save-hook 'my-autotex t t) ;; set the local flag to t
    (remove-hook 'after-save-hook 'my-autotex t)
    ))


(leaf latex-math-preview :ensure t)

;;
;; anything-math-symbols
;; http://emacswiki.org/emacs/AUCTeX

;; TODO: lacarte mathsymbol を helm に

;; (require 'anything-config)
;; (require 'lacarte)
;; (add-hook 'LaTeX-mode-hook
;;           (lambda ()
;;             (setq LaTeX-math-menu-unicode t)
;;             (define-key LaTeX-mode-map [?\M-`] 'anything-math-symbols)
;;             ))
;; (defvar anything-c-source-lacarte-math
;;   '((name . "Math Symbols")
;;     (init . (lambda()
;;               (setq anything-c-lacarte-major-mode major-mode)))
;;     (candidates
;;      . (lambda () (if (eq anything-c-lacarte-major-mode 'latex-mode)
;;                       (delete '(nil) (lacarte-get-a-menu-item-alist LaTeX-math-mode-map)))))
;;     (action . (("Open" . (lambda (candidate)
;;                            (call-interactively candidate)))))))
;; (defun anything-math-symbols ()
;;   "Anything for searching math menus"
;;   (interactive)
;;   (anything '(anything-c-source-lacarte-math)
;;             (thing-at-point 'symbol) "Symbol: "
;;             nil nil "*anything math symbols*"))



;; outline-magic
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
(leaf outline
  :bind ((outline-minor-mode-map ("<C-tab>" . outline-cycle)))
  :require t outline-magic
  :config
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq outline-promotion-headings
                    '("\\chapter" "\\section" "\\subsection"
                      "\\subsubsection" "\\paragraph" "\\subparagraph")))))


(leaf cdlatex
  :ensure t)
