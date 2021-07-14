
;; From https://emacs.stackexchange.com/questions/55024/how-to-make-a-temporary-directory-that-gets-deleted-once-the-body-is-finished
(defmacro with-temp-directory (temp-dir &rest body)
  `(let ((,temp-dir (make-temp-file "" t)))
    (unwind-protect
      (progn
        ,@body)
      (delete-directory ,temp-dir t))))

(defun find-file-upward (file-name &optional dir)
  (interactive)
  (let ((default-directory (file-name-as-directory (or dir default-directory))))
    (if (file-exists-p file-name)
        (expand-file-name file-name)
      (unless (string= "/" (directory-file-name default-directory))
        (find-file-upward file-name (expand-file-name ".." default-directory))))))

(defun git-repo-p ()
  (when (find-file-upward ".git") t))

(defun git-log-p-this-file ()
  (interactive)
  (let ((file (buffer-file-name)))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git-log-p-this-file*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command (concat "git log -p -- " file) nil buf t))
      (switch-to-buffer buf)
      (diff-mode)
      (goto-char (point-min)))))

(defun my-git-diff-this-file ()
  (interactive)
  (let ((file (buffer-file-name)))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git-diff*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command (concat "git diff " file) nil buf t))
      (switch-to-buffer buf)
      (diff-mode)
      (goto-char (point-min)))))

(defun my-git-checkout-this-file ()
  (interactive)
  (let ((file (buffer-file-name)))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../")))
      (with-temp-directory dir
         (call-process-shell-command (concat "git checkout -- " file) nil nil t))
      (revert-buffer nil t)
      )))


(defun my-git-log-origin ()
  (interactive)
  (let ((file (buffer-file-name)))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git fetch origin && git log origin*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command "git fetch origin && git log origin " nil buf t))
      (switch-to-buffer buf)
      (conf-mode)
      (goto-char (point-min)))))

(defun my-git-diff ()
  (interactive)
  (let ((file (buffer-file-name)))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git diff*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command (concat "git diff ") nil buf t))
      (switch-to-buffer buf)
      (diff-mode)
      (goto-char (point-min)))))

(defun my-git-log-S-this-file ()
  (interactive)
  (let ((file (buffer-file-name))
        (word (read-from-minibuffer "search word:")))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git log -S*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command (concat "git log -S'" word "' " file) nil buf t))
      (switch-to-buffer buf)
      ;; (diff-mode)
      (goto-char (point-min)))))

(defun my-git-log-S ()
  (interactive)
  (let ((word (read-from-minibuffer "search word:")))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git log -S*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command (concat "git log -S'" word "'") nil buf t))
      (switch-to-buffer buf)
      (conf-mode)
      (vc-annotate-mode)
      (goto-char (point-min)))))

;; git log -S'ordered_market_apps' path/to/file

(defun my-git-show-this-word ()
  (interactive)
  (let ((word (or (thing-at-point 'word) "")))
    (unless (git-repo-p) (error "git 管理下にありません"))
    (let ((dir (concat (find-file-upward ".git") "/../"))
          (buf "*git show*"))
      (with-temp-directory dir
         (awhen (get-buffer buf)
                (with-current-buffer it (erase-buffer)))
         (call-process-shell-command (concat "git show " word) nil buf t))
      (switch-to-buffer buf)
      (diff-mode)
      (goto-char (point-min)))))


(defalias 'glog 'git-log-p-this-file)
(defalias 'gdiff 'my-git-diff)
(defalias 'gdiff-this-file 'my-git-diff-this-file)
(defalias 'gco 'my-git-checkout-this-file)
(defalias 'gr 'my-git-log-origin)

(defalias 'glogs 'my-git-log-S)
(defalias 'glogs-this-file 'my-git-log-S-this-file)
(defalias 'gshow 'my-git-show-this-word)
;; (defalias 'rt  'my-rake-spec)

;; (use-package git-dwim)


(leaf browse-at-remote
  :ensure t)

(defun browse-github ()
  (interactive)
  (shell-command "hub browse"))

(defun pull-request ()
  (interactive)
  (shell-command "hub pull-request"))
