;;
;; helm
;;
(leaf helm
  :ensure t
  :config
  ;; (leaf helm-net :ensure t)
  ;; (leaf helm-config :ensure t)
  (leaf helm-descbinds :ensure t)
  (leaf helm-ag :ensure t)
  ;; (add-to-list 'helm-compile-source-functions 'helm-compile-source--migemo t)
  (setq helm-compile-source-functions nil)

  ;; (eval-after-load "helm"
  ;;   '(defun helm-compile-source--candidates-in-buffer (source)
  ;;      (helm-aif (assoc 'candidates-in-buffer source)
  ;;          (append source
  ;;                  `((candidates . ,(or (cdr it)
  ;;                                       (lambda ()
  ;;                                         (helm-candidates-in-buffer (helm-get-current-source)))))
  ;;                    (volatile) (match identity)))
  ;;        source)))


  (helm-descbinds-mode)
  (helm-descbinds-install)
  ;; (define-key global-map [(control ?:)] 'helm-migemo)
  ;; (setq helm-use-migemo t)
  (helm-mode 1)

  ;; helmコマンドで migemo を有効にする
  ;; (setq helm-migemize-command-idle-delay helm-idle-delay)
  ;; (setq helm-migemize-command-idle-delay 0.01)
  ;; (helm-migemize-command helm-for-files)
  ;; (helm-migemize-command helm-ag)
  ;; (helm-migemize-command helm-hatena-bookmark)
  ;; (helm-migemize-command helm-firefox-bookmarks)

  ;; https://github.com/emacs-helm/helm/wiki/Migemo
  (helm-migemo-mode t)


  ;; Disable them
  ;; (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
  (setq helm-completing-read-handlers-alist
        (delete (assoc 'find-file helm-completing-read-handlers-alist)
                helm-completing-read-handlers-alist))
  (add-to-list 'helm-completing-read-handlers-alist '(TeX-command-master . nil))
  (add-to-list 'helm-completing-read-handlers-alist '(execute-extended-command . nil))
  (add-to-list 'helm-completing-read-handlers-alist '(dired-do-copy . nil))


  ;; helm-swoop と org-mode を仲良くする（* を検索補完させない）
  ;; https://qiita.com/takaxp/items/34569a0e00d156802249
  (with-eval-after-load "helm-swoop"
    ;; カーソルの単語が org の見出し（*の集まり）のとき検索対象にしない．
    (setq helm-swoop-pre-input-function
          #'(lambda()
              (unless (thing-at-point-looking-at "^\\*+")
                (thing-at-point 'symbol)))))

  ;; http://emacs.rubikitch.com/helm-ag/
  ;; (setq helm-ag-base-command "grep -rin")
  ;; (setq helm-ag-base-command "ag --nocolor --nogroup")
  (setq helm-ag-base-command "rg --vimgrep --no-heading --ignore-case")
  ;; (setq helm-ag-insert-at-point 'symbol)

  (defun helm-ag-org ()
    "org/以下を検索"
    (interactive)
    (helm-ag "~/org/"))

  ;; おもしろ helm
  ;; from A Package in a league of its own: Helm - http://tuhdo.github.io/helm-intro.html
  ;; <prefix> = "C-x c"
  ;; helm-calcul-expression
  ;; <prefix> C-,



  ;; making my own sources
  (cond (darwin-p
         (defcustom my-helm-default-sources '(helm-source-buffers-list
                                              helm-source-recentf
                                              helm-source-mac-spotlight
                                              helm-source-buffer-not-found)
           "Default sources list used in `my-helm'."
           :group 'helm-misc
           :type '(repeat (choice symbol))))
        (t ;;linux-p
         (defcustom my-helm-default-sources '(helm-source-buffers-list
                                              helm-source-recentf
                                              helm-source-buffer-not-found)
           "Default sources list used in `my-helm'."
           :group 'helm-misc
           :type '(repeat (choice symbol)))))

  ;; helm-source-buffers-list+


  ;; (custom-set-faces
  ;;  '(helm-selection ((((class color)
  ;;                      (background dark))
  ;;                     (:background "LightBlue"))
  ;;                    (((class color)
  ;;                      (background light))
  ;;                     (:background "RoyalBlue"))
  ;;                    (t ())
  ;;                    )))
  ;; (set-face-background 'helm-selection "RoyalBlue")
  ;; (set-face-background 'helm-selection "LightBlue")

  ;; ;; patch

  ;; (defun helm-render-source (source matches)
  ;;   "Display MATCHES from SOURCE according to its settings."
  ;;   (helm-log "Source name = %S" (assoc-default 'name source))
  ;;   (when matches
  ;;     (helm-insert-header-from-source source)
  ;;     (if (not (assq 'multiline source))
  ;;         (cl-loop for m in matches
  ;;                  for count from 1
  ;;                  do (helm-insert-match m 'insert count source))
  ;;       (let ((start (point))
  ;;             (count 0)
  ;;             separate)
  ;;         (cl-dolist (match matches)
  ;;           (cl-incf count)
  ;;           (if separate
  ;;               (helm-insert-candidate-separator)
  ;;             (setq separate t))
  ;;           (helm-insert-match match 'insert count source))
  ;;         (put-text-property start (point) 'helm-multiline t)))))


  ;; start-processをよぶ
  (defclass helm-my-ag-source (helm-source-async helm-type-file)
    ((candidates-process :initform
                         (lambda ()
                           (start-process
                            "mdfind-process" nil "ag" helm-pattern)))
     (requires-pattern :initform 3)))

  (defvar my-helm-source-ag
    (helm-make-source "ag" 'helm-my-ag-source)
    "Source for retrieving files via Spotlight's command line
utility mdfind.")

  ;; (helm :sources 'my-helm-source-ag
  ;;       :ff-transformer-show-only-basename nil
  ;;       :buffer "*helm hoge*")

  
  (defun helm-select-2nd-action ()
    "Select the 2nd action for the currently selected candidate."
    (interactive)
    (helm-select-nth-action 1))

  (defun helm-select-3rd-action ()
    "Select the 3rd action for the currently selected candidate."
    (interactive)
    (helm-select-nth-action 2))

  (defun helm-select-4th-action ()
    "Select the 4th action for the currently selected candidate."
    (interactive)
    (helm-select-nth-action 3))

  (defun helm-select-2nd-action-or-end-of-line ()
    "Select the 2nd action for the currently selected candidate.
This happen when point is at the end of minibuffer.
Otherwise goto the end of minibuffer."
    (interactive)
    (if (eolp)
        (helm-select-nth-action 1)
      (end-of-line)))

  (define-key helm-map (kbd "C-e")        'helm-select-2nd-action-or-end-of-line)
  (define-key helm-map (kbd "C-j")        'helm-select-3rd-action)
  (define-key helm-map (kbd "C-z") 'helm-execute-persistent-action)
  )

(defun my-helm ()
  "Preconfigured `helm' my version."
  (interactive)
  (require 'helm-x-files)
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))
  (let ((helm-ff-transformer-show-only-basename nil))
    (helm :sources my-helm-default-sources 
          :buffer "*my helm*"
          :ff-transformer-show-only-basename nil
          :truncate-lines helm-buffers-truncate-lines)))
