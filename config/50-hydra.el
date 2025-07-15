;; -*- lexical-binding: t; -*-

(leaf hydra
  :ensure t
  :bind
  ("C-z" . hydra-viewer/body)
  ("C-c ." . help/hydra/timestamp/body)
  :config
  (with-eval-after-load 'hydra
    (defhydra hydra-viewer (:color pink :hint nil)
      "
                                                                        ╔════════╗
   Char/Line^^^^^^  Word/Page^^^^^^^^  Line/Buff^^^^   Paren                              ║ Window ║
  ──────────────────────────────────────────────────────────────────────╨────────╜
       ^^_k_^^          ^^_u_^^          ^^_g_^^       _(_ ← _y_ → _)_
       ^^^↑^^^          ^^^↑^^^          ^^^↑^^^       _,_ ← _/_ → _._
   _h_ ← _d_ → _l_  _H_ ← _D_ → _L_  _a_ ← _K_ → _e_
       ^^^↓^^^          ^^^↓^^^          ^^^↓^
       ^^_j_^^          ^^_n_^^          ^^_G_
  ╭──────────────────────────────────────────────────────────────────────────────╯
                           [_q_]: quit, [_<SPC>_]: center
          "
      ("j" scroll-down-line)
      ("k" scroll-up-line)
      ("l" forward-char)
      ("d" delete-char)
      ("h" backward-char)
      ("L" forward-word)
      ("H" backward-word)
      ("u" scroll-up-command)
      ("n" scroll-down-command)
      ("D" delete-word-at-point)
      ("a" mwim-beginning-of-code-or-line)
      ("e" mwim-end-of-code-or-line)
      ("g" beginning-of-buffer)
      ("G" end-of-buffer)
      ("K" kill-whole-line)
      ("(" backward-list)
      (")" forward-list)
      ("y" yank-inner-sexp)
      ("." backward-forward-next-location)
      ("," backward-forward-previous-location)
      ("/" avy-goto-char :exit t)
      ("<SPC>" recenter-top-bottom)
      ("q" nil))

    (defhydra help/hydra/timestamp (:color blue :hint none)
      "
   === Timestamp ===                                                     _q_uit
0.  ?i? (_i_so 8601)    ?n? (_n_ow)    ?w? (_w_eek)    ?a? (week-d_a_y)
_1_.  ?t? (ISO 8601 including _t_imezone)
_2_.  ?r?    (Org Mode: _r_ight now)
_3_.  ?s?          (Org Mode: by _s_elect)
"
      ("q" nil)
      ("i" help/insert-datestamp (format-time-string "%F"))
      ("n" help/insert-currenttime (format-time-string "%H:%M"))
      ("w" help/insert-week (format-time-string "%W"))
      ("a" help/insert-month-and-day (format-time-string "%m%d"))
      ("t" help/insert-timestamp (help/get-timestamp))
      ("r" help/org-time-stamp-with-seconds-now
       (format-time-string "<%F %a %H:%M>"))
      ("s" org-time-stamp (format-time-string "<%F %a>"))
      ("0" help/show-my-date)
      ("1" help/insert-timestamp)
      ("2" help/org-time-stamp-with-seconds-now)
      ("3" org-time-stamp))

    (defun help/show-my-date ()
      "Produces and show date and time in preferred format."
      (interactive)
      (message (format-time-string "%Y-%m-%d (%a.) W:%W @%H:%M"))
      (hydra-keyboard-quit))

    (defun help/insert-currenttime ()
      "Produces and inserts the current time."
      (interactive)
      (insert (format-time-string "%H:%M")))

    (defun help/insert-week ()
      "Produces and inserts the week number."
      (interactive)
      (insert (format-time-string "%W")))

    (defun help/insert-month-and-day ()
      "Inserts a month and day pair in 4-degits."
      (interactive)
      (insert (format-time-string "%m%d")))

    (defun help/insert-datestamp ()
      "Produces and inserts a partial ISO 8601 format timestamp."
      (interactive)
      (insert (format-time-string "%F")))

    (defun help/insert-timestamp ()
      "Inserts a full ISO 8601 format timestamp."
      (interactive)
      (insert (help/get-timestamp)))

    (defun help/org-time-stamp-with-seconds-now ()
      (interactive)
      (let ((current-prefix-arg '(16)))
        (call-interactively 'org-time-stamp)))

    (defun help/get-timestamp ()
      "Produces a full ISO 8601 format timestamp."
      (interactive)
      (let* ((timestamp-without-timezone (format-time-string "%Y-%m-%dT%T"))
             (timezone-name-in-numeric-form (format-time-string "%z"))
             (timezone-utf-offset
              (concat (substring timezone-name-in-numeric-form 0 3)
                      ":"
                      (substring timezone-name-in-numeric-form 3 5)))
             (timestamp (concat timestamp-without-timezone
                                timezone-utf-offset)))
        timestamp))
    ))

(leaf hydra-posframe
  :doc "Show hidra hints on posframe"
  :url "https://github.com/Ladicle/hydra-posframe"
  :if (window-system)
  :el-get Ladicle/hydra-posframe
  :global-minor-mode hydra-posframe-mode
  :custom
  (hydra-posframe-border-width . 5)
  (hydra-posframe-parameters . '((left-fringe . 8) (right-fringe . 8)))
  :custom-face
  (hydra-posframe-border-face . '((t (:background "#323445")))))

(leaf major-mode-hydra
  :doc "Use pretty-hydra to define template easily"
  :url "https://github.com/jerrypnz/major-mode-hydra.el"
  :ensure t
  :require pretty-hydra)

(leaf *org-hydra
  :doc "Hydra template for org metadata"
  :bind
  ((:org-mode-map
    :package org
    ("#" . insert-or-open-org-hydra)))
  :preface
  (defun insert-or-open-org-hydra ()
    (interactive)
    (if (or (region-active-p) (looking-back "^\s*" 1))
        (*org-hydra/body)
      (self-insert-command 1)))
  :pretty-hydra
  ((:title " Org Mode" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Header"
    (("t" (insert "#+title: ") "title")
     ("h" (insert "#+html_head: <style></style>") "html_head") 
     ("l" (insert "#+LATEX_CLASS: ") "LATEX_CLASS")
     ("o" (insert "#+tags: ") "tags")
     ("f" (insert "#+filetags: ") "filetags")
     ("a" (insert (format-time-string "#+lastmod: [%Y-%m-%d %a %H:%M]" (current-time))) "lastmod")))))

(leaf *hydra-goto
  :doc "Search and move cursor"
  :bind ("M-j" . *hydra-goto/body)
  :pretty-hydra
  ((:title " Goto" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Goto"
    (("i" avy-goto-char         "char")
     ("t" avy-goto-migemo-timer "migemo timer")
     ("w" avy-goto-word-0       "word")
     ("j" avy-resume            "resume"))
    "Line"
    (("h" avy-goto-line        "head")
     ("e" avy-goto-end-of-line "end")
     ("n" consult-goto-line    "number"))
    "Topic"
    (("o"  consult-outline      "outline")
     ("m"  consult-imenu        "imenu")
     ("gm" consult-global-imenu "global imenu"))
    "Error"
    ((","  flycheck-previous-error "previous" :exit nil)
     ("."  flycheck-next-error "next" :exit nil)
     ("l"  consult-flycheck "list"))
    "Spell"
    ((">"  flyspell-goto-next-error "next" :exit nil)
     ("cc" flyspell-correct-at-point "correct" :exit nil)))))

(leaf *hydra-toggle
  :doc "Toggle functions"
  :bind ("M-t" . *hydra-toggle/body)
  :pretty-hydra
  ((:title " Toggle" :color blue :quit-key "q" :foreign-keys warn :separator "-")
   ("Basic"
    (("v" view-mode "view mode" :toggle t)
     ;;("w" whitespace-mode "whitespace" :toggle t)
     ;;("W" whitespace-cleanup "whitespace cleanup")
     ;;("r" rainbow-mode "rainbow" :toggle t)
     ;;("b" beacon-mode "beacon" :toggle t)
     ("o" org-modern-mode "org-modern" :toggle t)
     ("s" svg-tag-mode "svg-tag" :toggle t)
     )
    "Line & Column"
    (("l" toggle-truncate-lines "truncate line" :toggle t)
     ("n" display-line-numbers-mode "line number" :toggle t)
     ("f" display-fill-column-indicator-mode "column indicator" :toggle t)
     ("c" visual-fill-column-mode "visual column" :toggle t))
    "Highlight"
    (;;("h" highlight-symbol "highligh symbol" :toggle t)
     ;;("L" hl-line-mode "line" :toggle t)
     ;;("t" hl-todo-mode "todo" :toggle t)
     ("g" git-gutter-mode "git gutter" :toggle t)
     ;;("i" highlight-indent-guides-mode "indent guide" :toggle t)
     )
    ;; "Window"
    ;; (("t" toggle-window-transparency "transparency" :toggle t)
    ;;  ("m" toggle-window-maximize "maximize" :toggle t)
    ;;  ("p" presentation-mode "presentation" :toggle t)
    ;;  )
    )))
