;; (ag-highlight-search t)  ; 検索結果の中の検索語をハイライトする
;; (ag-reuse-window 'nil)   ; 現在のウィンドウを検索結果表示に使う
;; (ag-reuse-buffers 'nil)) ; 現在のバッファを検索結果表示に使う
(leaf ag
  :ensure t
  :custom ((ag-highlight-search . t)
           (ag-reuse-window . 'nil)
           (ag-reuse-buffers . 'nil)))

;; ag した結果のバッファをそのまま編集できる wgrep の ag 版
(leaf wgrep-ag
  :ensure t
  :bind ((ag-mode-map
          ("r" . wgrep-change-to-wgrep-mode)))
  :hook ((ag-mode-hook . wgrep-ag-setup)))
