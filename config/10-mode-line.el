;; -*- lexical-binding: t; -*-

;; From http://peccu.hatenablog.com/entry/2015/05/02/000000
;; Show Git branch information to mode-line
(let ((cell (or (memq 'mode-line-position mode-line-format)
                (memq 'mode-line-buffer-identification mode-line-format)))
      (newcdr '(:eval (my/update-git-branch-mode-line))))
  (unless (member newcdr mode-line-format)
    (setcdr cell (cons newcdr (cdr cell)))))

(defun my/update-git-branch-mode-line ()
  (let* ((branch (replace-regexp-in-string
                  "[\r\n]+\\'" ""
                  (shell-command-to-string "git symbolic-ref -q HEAD")))
         (mode-line-str (if (string-match "^refs/heads/" branch)
                            (cond
                             ((string-match "^refs/heads/feature/" branch)
                              (format "[f/%s]" (substring branch 19)))
                             ((string-match "^refs/heads/release/" branch)
                              (format "[r/%s]" (substring branch 19)))
                             ((string-match "^refs/heads/hotfix/" branch)
                              (format "[h/%s]" (substring branch 18)))
                             (t
                              (format "[%s]" (substring branch 11))))
                          "-")))
    (propertize mode-line-str
                'face 'my/git-repository-face)))

(defface my/git-repository-face
  '((((class color) (background dark)) :foreground "spring green")
    (((class color) (background light)) :foreground "dark green")
    (t :weight bold))
  "Git mode-line face"
  :group 'my/git-mode-line-faces)
