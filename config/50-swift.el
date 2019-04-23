(use-package swift-mode
  :defer t
  :config
  (setq flycheck-swift-sdk-path
      (replace-regexp-in-string
       "\n+$" "" (shell-command-to-string
                  "xcrun --show-sdk-path --sdk macosx")))
  (setq swift "/usr/bin/swift")
  ;; (add-to-list 'flycheck-checkers 'swift)
)

;; (setq flycheck-swift-sdk-path "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk")
;; (setq swift "swift")

;; (add-to-list 'flycheck-checkers 'swift)
