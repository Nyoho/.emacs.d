(use-package hydra)

(defhydra hydra/move ()
  "move"
  ("f" forward-char "right")
  ("b" backward-char "left")
  ("n" next-line "down")
  ("p" previous-line "up")
  ("SPC" scroll-up-command "down")
  ("<backspace>" scroll-down-command "up")
  ("." hydra-repeat "repeat"))

(global-set-key (kbd "C-z") #'hydra/move/body)
(global-set-key (kbd "C-c .") #'help/hydra/timestamp/body)

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
