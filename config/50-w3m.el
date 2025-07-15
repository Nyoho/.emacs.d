;; -*- lexical-binding: t; -*-
;;
;; for emacs-w3m
;;
(leaf w3m
  :when (setq w3m-command (executable-find "w3m"))
  :ensure t
  :after t
  :setq
  ((w3m-use-cookies . t)
   (w3m-use-form . t)
   (w3m-display-inline-image . t)))

(leaf w3m-cookie
  :after w3m
  :require t)

;; (global-set-key "\C-xm" 'browse-url-at-point)
;; (define-key w3m-mode-map "\C-xm" 'browse-url-at-point)
;; (setq w3m-home-page "/Users/nyoho/.w3m/bookmark.html")


;;(require 'izonmoji-mode)
;;(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
;;(autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)

;; browse-url w3m
;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;;(setq browse-url-browser-function 'w3m-browse-url)
;; (setq browse-url-netscape-program
;;       (expand-file-name "~/bin/open_navigator.sh"))
;;(setq w3m-mailto-url-function 'wl-draft)

;;(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)

;;(setq w3m-search-default-engine "google-ja")
;; (setq w3m-view-url-with-external-browser
;;       (expand-file-name "~/bin/open_navigator.sh"))

;;(global-set-key "\C-cs" 'w3m-search)

;;(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
;;(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)

;;(setq w3m-content-type-alist
;;'(("image/jpeg" "\\.jpe?g$" ("openurl" file))
;; ("image/png" "\\.png$" ("openurl" file))
;; ("image/gif" "\\.gif$" ("openurl" file))
;; ("image/tiff" "\\.tif?f$" ("openurl" file))))
