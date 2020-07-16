(leaf font-setting
  :disabled nil
  :when window-system
  :config
  ;; 使えるフォント一覧
  ;; (insert (prin1-to-string (x-list-fonts "*")))
  ;; or
  ;; (with-output-to-temp-buffer "*Font family list*" (dolist (font (font-family-list))  (princ (format "%s\n" font))))

  (set-face-attribute 'default nil :family "Ricty Diminished Discord" :height 160)
  ;; (set-face-attribute 'default nil :family "Cica" :height 160)

  ;; (setq face-font-rescale-alist
  ;;       '(("Hiragino Maru Gothic ProN" . 1.2)
  ;;         ("Hiragino Kaku Gothic ProN" . 1.2)))

  ;; (set-fontset-font nil 'mule-unicode-0100-24ff '("monaco" . "iso10646-1"))
  ;; (set-fontset-font nil '(#x00 . #xff) (font-spec :family "Monaco" :size 14 :baseline 0))
  (set-fontset-font nil 'japanese-jisx0208  (font-spec :family "Hiragino Kaku Gothic ProN"))
  (set-fontset-font nil 'greek-iso8859-7 (font-spec :family "New Athena Unicode"))

  ;; 3000-303F CJKの記号及び句読点
  ;; https://ja.wikipedia.org/wiki/CJK%E3%81%AE%E8%A8%98%E5%8F%B7%E5%8F%8A%E3%81%B3%E5%8F%A5%E8%AA%AD%E7%82%B9
  ;; 〝
  ;; (set-fontset-font nil '(#x3000 . #x303f) (font-spec :family "September"))
  (set-fontset-font nil '(#x3000 . #x303f) (font-spec :family "Osaka"))

  ;; 3040-309f 全角ひらがな, 30a0-30ff 全角カタカナ
  ;; https://ja.wikipedia.org/wiki/%E5%B9%B3%E4%BB%AE%E5%90%8D_(Unicode%E3%81%AE%E3%83%96%E3%83%AD%E3%83%83%E3%82%AF)
  ;; (set-fontset-font nil '(#x3040 . #x30ff) (font-spec :family "Capanito"))
  (set-fontset-font nil '(#x3040 . #x30ff) (font-spec :family "Hiragino Kaku Gothic ProN"))

  ;; ｶﾀｶﾅ (半角カタカナ)、ｈｏｇｅＨＯＧＥ (全角アルファベット)
  ;; ff00-ffef http://www.triggertek.com/r/unicode/FF00-FFEF
  (set-fontset-font nil 'katakana-jisx0201 (font-spec :family "Hiragino Kaku Gothic ProN"))
  ;; (set-fontset-font nil '(#xff00 . #xffef) (font-spec :family "Hiragino Kaku Gothic ProN"))
  ;; (set-fontset-font nil '(#xff00 . #xffef) (font-spec :family "September"))

  (set-fontset-font nil '(#xff5e . #xff5e) (font-spec :family "Hiragino Kaku Gothic ProN"))
  (set-fontset-font nil '(#xff0d . #xff0d) (font-spec :family "Hiragino Kaku Gothic ProN"))

  ;; ►
  ;; (set-fontset-font nil '(#x25b0 . #x25ff) (font-spec :family "Lucida Grande"))
  ;; (set-fontset-font nil '(#x2500 . #x25ff) (font-spec :family "Consolas"))
  ;; (set-fontset-font nil '(#x2501 . #x257f) (font-spec :family "Hiragino Kaku Gothic ProN"))

  ;; japanese-jisx0213.2004-1 (JISX0213.2004 Plane1 (Japanese))
  ;; 北䑓, 川﨑
  ;; (set-fontset-font nil 'japanese-jisx0213.2004-1 (font-spec :family "Hiragino Kaku Gothic ProN"))

  ;; emoji
  ;; (set-fontset-font nil '(#xde00 . #xdeff) (font-spec :family "Hiragino Kaku Gothic ProN"))
  ;; (set-fontset-font nil '(#xde00 . #xdeff) (font-spec :family "Symbola"))
  
  ;; East Asian Ambiguous Width ○×α
  (use-cjk-char-width-table 'ja_JP)
  )

;; Test text from https://qiita.com/kaz-yos/items/0f23d53256c2a3bd6b8d
;; |012345 678910|
;; |abcdef ghijkl|
;; |ABCDEF GHIJKL|
;; |αβγδεζ ηθικλμ|
;; |ΑΒΓΔΕΖ ΗΘΙΚΛΜ|
;; |∩∪∞≤≥∏ ∑∫×±⊆⊇|
;; |'";:-+ =/\~`?|
;; |日本語 の美観|
;; |あいう えおか|
;; |アイウ エオカ|
;; |ｱｲｳｴｵｶ ｷｸｹｺｻｼ|
;;
;; | hoge                 | hogehoge | age               |
;; |----------------------+----------+-------------------|
;; | 今日もいい天気ですね | お、     | 等幅になった 👍 |
;; | 🎙マイクで🌈虹が出る | お、     | 等幅になった 👍 |
