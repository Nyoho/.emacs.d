(leaf emacs-lisp
  :hook (emacs-lisp-mode . smartparens-mode))

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

(leaf scratch-comment
  :ensure t
  :bind ((lisp-interaction-mode-map
          :package elisp-mode
          ("C-c C-j" . scratch-comment-eval-sexp))))

(leaf lispy :ensure t)

(leaf parinfer-rust-mode
  :ensure t
  :hook emacs-lisp-mode)

(leaf eldoc-box
  :url "https://github.com/casouri/eldoc-box"
  :ensure t)

(leaf paredit
  :ensure t
  :hook ((emacs-lisp-mode-hook . enable-paredit-mode)
         (lisp-interacton-mode-hook . enable-paredit-mode)))

;; From ROCKTAKEY
(defvar my:eldoc-symbol nil)
(defun my:first-line (string)
  (car (split-string string "\n")))
(defun my:eldoc-docstring-format-sym-doc (orig-func &rest args)
  (if my:eldoc-symbol
      (let* ((prefix (nth 0 args))
             (doc    (nth 1 args))
             (face   (nth 2 args))
             (function-name
              (propertize (symbol-name my:eldoc-symbol)
                          'face face))
             (spec (format "%s %s" prefix doc))
             (docstring (or
                         (documentation my:eldoc-symbol t) ;get documentation
                         "Undocumented."))
             (docstring (propertize (my:first-line docstring)
                                    'face 'font-lock-doc-face))
             ;; TODO: currently it strips from the start of spec by
             ;; character instead of whole arguments at a time.
             (fulldoc (format "%s %s" spec docstring))
             (ea-width (1- (window-width (minibuffer-window)))))
        (setq my:eldoc-symbol nil)
        (cond ((or (<= (length fulldoc) ea-width)
                   (eq eldoc-echo-area-use-multiline-p t)
                   (and eldoc-echo-area-use-multiline-p
                        (> (length docstring) ea-width)))
               fulldoc)
              ((> (length docstring) ea-width)
               (substring docstring 0 ea-width))
              ((>= (- (length fulldoc) (length spec)) ea-width)
               docstring)
              (t
               ;; Show the end of the partial symbol name, rather
               ;; than the beginning, since the former is more likely
               ;; to be unique given package namespace conventions.
               (setq spec (substring spec (- (length fulldoc) ea-width)))
               (format "%s: %s" spec docstring))))
    (apply orig-func args)
    ))
(defun my:elisp--highlight-function-argument (sym args index prefix)
  "Highlight argument INDEX in ARGS list for function SYM.
In the absence of INDEX, just call `eldoc-docstring-format-sym-doc'."
  ;; FIXME: This should probably work on the list representation of `args'
  ;; rather than its string representation.
  ;; FIXME: This function is much too long, we need to split it up!
  (let* ((start          nil)
         (end            0)
         (argument-face  'eldoc-highlight-function-argument)
         (args-lst (mapcar (lambda (x)
                             (replace-regexp-in-string
                              "\\`[(]\\|[)]\\'" "" x))
                           (split-string args)))
         (args-lst-ak (cdr (member "&key" args-lst))))
    (setq my:eldoc-symbol sym)
    ;; Find the current argument in the argument string.  We need to
    ;; handle `&rest' and informal `...' properly.
    ;;
    ;; FIXME: What to do with optional arguments, like in
    ;;        (defun NAME ARGLIST [DOCSTRING] BODY...) case?
    ;;        The problem is there is no robust way to determine if
    ;;        the current argument is indeed a docstring.
    ;; When `&key' is used finding position based on `index'
    ;; would be wrong, so find the arg at point and determine
    ;; position in ARGS based on this current arg.
    (when (and args-lst-ak
               (>= index (- (length args-lst) (length args-lst-ak))))
      (let* (case-fold-search
             key-have-value
             (sym-name (symbol-name sym))
             (cur-w (current-word t))
             (limit (save-excursion
                      (when (re-search-backward sym-name nil t)
                        (match-end 0))))
             (cur-a (if (and cur-w (string-match ":\\([^ ()]*\\)" cur-w))
                        (substring cur-w 1)
                      (save-excursion
                        (let (split)
                          (when (re-search-backward ":\\([^ ()\n]*\\)" limit t)
                            (setq split (split-string (match-string 1) " " t))
                            (prog1 (car split)
                              (when (cdr split)
                                (setq key-have-value t))))))))
             ;; If `cur-a' is not one of `args-lst-ak'
             ;; assume user is entering an unknown key
             ;; referenced in last position in signature.
             (other-key-arg (and (stringp cur-a)
                                 args-lst-ak
                                 (not (member (upcase cur-a) args-lst-ak))
                                 (upcase (car (last args-lst-ak))))))
        (unless (or (null cur-w) (string= cur-w sym-name))
          ;; The last keyword have already a value
          ;; i.e :foo a b and cursor is at b.
          ;; If signature have also `&rest'
          ;; (assume it is after the `&key' section)
          ;; go to the arg after `&rest'.
          (if (and key-have-value
                   (save-excursion
                     (not (re-search-forward ":.*" (point-at-eol) t)))
                   (string-match "&rest \\([^ ()]*\\)" args))
              (setq index nil ; Skip next block based on positional args.
                    start (match-beginning 1)
                    end   (match-end 1))
            ;; If `cur-a' is nil probably cursor is on a positional arg
            ;; before `&key', in this case, exit this block and determine
            ;; position with `index'.
            (when (and cur-a     ; A keyword arg (dot removed) or nil.
                       (or (string-match
                            (concat "\\_<" (upcase cur-a) "\\_>") args)
                           (string-match
                            (concat "\\_<" other-key-arg "\\_>") args)))
              (setq index nil ; Skip next block based on positional args.
                    start (match-beginning 0)
                    end   (match-end 0)))))))
    ;; Handle now positional arguments.
    (while (and index (>= index 1))
      (if (string-match "[^ ()]+" args end)
          (progn
            (setq start (match-beginning 0)
                  end   (match-end 0))
            (let ((argument (match-string 0 args)))
              (cond ((string= argument "&rest")
                     ;; All the rest arguments are the same.
                     (setq index 1))
                    ((string= argument "&optional"))         ; Skip.
                    ((string= argument "&allow-other-keys")) ; Skip.
                    ;; Back to index 0 in ARG1 ARG2 ARG2 ARG3 etc...
                    ;; like in `setq'.
                    ((or (and (string-match-p "\\.\\.\\.\\'" argument)
                              (string= argument (car (last args-lst))))
                         (and (string-match-p "\\.\\.\\.\\'"
                                              (substring args 1 (1- (length args))))
                              (= (length (remove "..." args-lst)) 2)
                              (> index 1) (eq (logand index 1) 1)))
                     (setq index 0))
                    (t
                     (setq index (1- index))))))
        (setq end           (length args)
              start         (1- end)
              argument-face 'font-lock-warning-face
              index         0)))
    (let ((doc args))
      (when start
        (setq doc (copy-sequence args))
        (add-text-properties start end (list 'face argument-face) doc))
      (setq doc (eldoc-docstring-format-sym-doc prefix doc))
      doc)))
;; (advice-add #'elisp--highlight-function-argument
;;             :override
;;             #'my:elisp--highlight-function-argument)
;; (advice-add #'eldoc-docstring-format-sym-doc
;;             :around
;;             #'my:eldoc-docstring-format-sym-doc)
