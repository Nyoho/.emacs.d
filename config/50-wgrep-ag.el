;; (el-get 'sync '(ag wgrep-ag))
(use-package ag
  :defer t
  :config
  (custom-set-variables
   '(ag-highlight-search t)  ; 検索結果の中の検索語をハイライトする
   '(ag-reuse-window 'nil)   ; 現在のウィンドウを検索結果表示に使う
   '(ag-reuse-buffers 'nil)) ; 現在のバッファを検索結果表示に使う
  )

;; ag した結果のバッファをそのまま編集できる wgrep の ag 版
(use-package wgrep-ag
  :defer t
  :config
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup)
  (define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode))
