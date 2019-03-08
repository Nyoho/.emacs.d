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


(with-eval-after-load "LaTeX"
  (define-key LaTeX-mode-map (kbd "/") 'sesame-slash-dwim))
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
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
;; 日本語 TeX 用の設定
(setq TeX-default-mode 'japanese-latex-mode)

(setq japanese-LaTeX-default-style "jsarticle")
(setq japanese-LaTeX-default-style "jsarticle")
;; (setq japanese-TeX-command-default "jTeX")
(setq japanese-TeX-command-default "pTeX")
;; (setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-LaTeX-command-default "pdfpLaTeX")

;; preview-latex で dvipng を使う
(setq preview-image-type 'dvipng)


;; View open hogehoge.pdf 
(setq TeX-output-view-style '())
(add-to-list 'TeX-output-view-style
             '("^dvi$" "." "open %s.pdf"))
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

;; (add-hook 'TeX-mode-hook
;; 	  (function
;; 	   (lambda ()
;; 	     (setq TeX-command-default "pLaTeX")
;; 	     (setq japanese-TeX-command-default "pTeX")
;;      (setq japanese-LaTeX-command-default "pLaTeX")
;; 	     )))
;; (setq japanese-LaTeX-default-style "jarticle")
;; (setq kinsoku-limit 10)

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
(setq preview-image-type 'dvipng)

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

(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)

(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX" "platex -synctex=1 %t && dvipdfmx %d"
                                     ;; '("pdfpLaTeX" "platex -synctex=1 %t && dvipdfmx -f ~/tex/texinputs/hiragino-embed %d"
                                     ;; '("pdfpLaTeX" "platex -kanji=sjis -synctex=1 %t && dvipdfmx -f ~/tex/texinputs/hiragino-embed %d"
                                     ;; /usr/local/texlive/texmf-local/fonts/map/dvipdfm/hiragino-embed
                                     TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("Nonstop-pdfpLaTeX" "platex -synctex=1 -interaction=nonstopmode %t && dvipdfmx %d || SayKana エラーですけど"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("PythonTeX-dvipdfmx" "pythontex %t && platex -synctex=1 -interaction=nonstopmode %t pythontex %t && platex -synctex=1 -interaction=nonstopmode %t && dvipdfmx %d || SayKana エラーですよ"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, pythontex, platex, and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("only-PythonTeX" "pythontex %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, pythontex, platex, and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX2" "platex -synctex=1 %t && dvips -Ppdf -t a4 -z -f %d | convbkmk -g > %f && /usr/local/bin/ps2pdf %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-pLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX" "uplatex -synctex=1 %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-upLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX2" "uplatex -synctex=1 %t && dvips -Ppdf -t a4 -z -f %d | convbkmk -u > %f && /usr/local/bin/ps2pdf %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run e-upLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("XeLaTeX" "xelatex -synctex=1 %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run XeLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("pBibTeX" "pbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run pBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("upBibTeX" "upbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run upBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Mendex" "mendex %s"
                                     TeX-run-command nil t :help "Create index file with mendex"))
                      (add-to-list 'TeX-command-list
                                   '("Preview" "/usr/bin/open -a Preview.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Preview"))
                      (add-to-list 'TeX-command-list
                                   '("TeXShop" "/usr/bin/open -a TeXShop.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXShop"))
                      (add-to-list 'TeX-command-list
                                   '("TeXworks" "/usr/bin/open -a TeXworks.app %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXworks"))
                      (add-to-list 'TeX-command-list
                                   '("View" "/Applications/Skim.app/Contents/SharedSupport/displayline %n %s.pdf %b"
                                     TeX-run-discard-or-function t t :help "Forward search with Skim"))
                      (add-to-list 'TeX-command-list
                                   '("pdfopen" "/usr/bin/open -a \"Adobe Reader.app\" %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Adobe Reader")))))

;; (setq TeX-parse-self t)
;; (setq TeX-auto-save t)

;;
;; RefTeX (AUCTeX)
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)


(use-package tex
  :defer t
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

;; automatically run background TeX process
;; AUCTeX の設定と便利な機能 | Amrta
;; http://skalldan.wordpress.com/2011/07/20/auctex-%25E3%2581%25AE%25E8%25A8%25AD%25E5%25AE%259A%25E3%2581%25A8%25E4%25BE%25BF%25E5%2588%25A9%25E3%2581%25AA%25E6%25A9%259F%25E8%2583%25BD/#sec-6
(defun my-autotex ()
  (interactive)
  (when (string-match "\\.tex$" (buffer-file-name))
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
;; wrapper
(define-minor-mode my-autotex-mode
  "My autotex mode."
  :global nil
  :lighter " Auto"
  (if my-autotex-mode
      (add-hook 'after-save-hook 'my-autotex t t) ;; set the local flag to t
    (remove-hook 'after-save-hook 'my-autotex t)
    ))
;; Adds it to hooks
(add-hook 'TeX-mode-hook
          (lambda ()
            (my-autotex-mode 1)
            ))
(add-hook 'LaTeX-mode-hook
          (lambda ()
            (my-autotex-mode 1)
            ))


;; latex-math-preview.el
(autoload 'latex-math-preview-expression "latex-math-preview" nil t)
(autoload 'latex-math-preview-insert-symbol "latex-math-preview" nil t)
(autoload 'latex-math-preview-save-image-file "latex-math-preview" nil t)
(autoload 'latex-math-preview-beamer-frame "latex-math-preview" nil t)


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
(use-package outline
  :config
  (require 'outline-magic)
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq outline-promotion-headings
                    '("\\chapter" "\\section" "\\subsection"
                      "\\subsubsection" "\\paragraph" "\\subparagraph"))))
  (define-key outline-minor-mode-map (kbd "<C-tab>") 'outline-cycle)
  )
