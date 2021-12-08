

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; コマンドメモ
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defun memo ()
(interactive)
(get-buffer-create "my-memo")
(switch-to-buffer (get-buffer "my-memo"))
(insert
"'scroll-all-mode
\t表示中の全バッファを同時にスクロールするようになる

C-x o
\tウィンドウを右へ移動

C-x O
'previous-multiframe-window
\tウィンドウを左へ移動

C-x +
\tウィンドウサイズの均等化

C-x C-+(C-S-;)
\t画面の拡大

C-x command-+(command-S-;)
\t画面の拡大(mac)

C-x C--
\t画面の縮小

C-x command--
\t画面の縮小(mac)

'enlarge-window-horizontally
\t現在のウィンドウサイズの幅拡大

'shrink-window-horizontally
\t現在のウィンドウサイズの幅縮小

'enlarge-window
\t現在のウィンドウサイズの高さ拡大

'shrink-window
\t現在のウィンドウサイズの高さ拡大

'replace-string
\t置換

'goto-line
\t指定行にジャンプ

'scroll-lock-mode
\tカーソル位置を固定したままスクロールする

'delete-trailing-whitespace
\t行末のスペース削除

'flush-lines ^$
\t空行削除

'kill-whole-line
\t行削除

'kill-some-buffers
\t開いているバッファを全て閉じる

'apropos
\t命令を探す

'tabify
\tregionのスペースをタブに変換

'untabify
\tregionのタブをスペースに変換

'grep
\tgrep -nHrie 検索文字列[ -e 検索文字列 ...] ファイル名(rオプションをつけた時はトップのディレクトリパス)
\tn: 行番号表示
\tH: ファイル名表示
\tr: 子孫ディレクトリも検索
\ti: 大文字小文字の違いを無視
\t例: grep -nHrie hoge ~/

'kill-ring-clear
\tkill-ringのクリアー

'whitespace-mode
\tタブや空白を可視化する
\tゴミの削除に使える

C-SPC C-SPC
\tポイントを保存
\tファイル内のみ

C-u C-SPC
\tポイントへジャンプ
\tファイル内のみ

C-x r SPC [1文字入力]
\tポイントを保存
\tファイル間移動可

C-x r j [1文字入力]
\tポイントへジャンプ
\tファイル間移動可
")
(help-mode)
(goto-char (point-min))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; インデント設定
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;---------------------------------------
;; mode設定
;; https://github.com/google/styleguide
;; http://web-mode.org/
;;---------------------------------------
;(load-file "~/google-c-style.el")
;(require 'google-c-style)

(global-set-key (kbd "C-h") 'delete-backward-char) (load-file "~/web-mode.el")
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

(load-file "~/kotlin-mode-lexer.el")
(load-file "~/kotlin-mode.el")

;;--------------------------------------------------
;; インデント設定
;; google coding style guideに従う
;; google coding style guideに無いphpはwordpressのコーディング規約に従う
;;--------------------------------------------------
(add-hook 'c-mode-common-hook 'custom-php-mode-hook)

(add-hook 'php-mode-hook 'custom-php-mode-hook)
(add-hook 'web-mode-hook 'custom-php-mode-hook)

(defun custom-web-mode-hook ()
; Google coding style indent
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

; color
(set-face-attribute 'web-mode-html-tag-bracket-face nil :foreground "#fff")
(set-face-attribute 'web-mode-html-tag-face nil :foreground "#fff")
(set-face-attribute 'web-mode-html-attr-name-face nil :foreground "#0f0")
)

(defun custom-php-mode-hook ()
; WordPress coding style indent
;(setq indent-tabs-mode t)
(setq-default indent-tabs-mode nil)
(setq indent-tabs-mode nil)
(setq c-basic-offset 4)
(setq tab-width 4)
(c-set-offset 'arglist-close 0)
(c-set-offset 'defun-close 0)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; エディタ機能
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;--------------------------------------------------
;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
;;--------------------------------------------------
(global-set-key "\C-xO" 'previous-multiframe-window)

;;--------------------------------------------------
;; *scratch* を削除しない。
;; *scratch* を保存する(名前が変わる)と新しく *scratch* を作る
;;--------------------------------------------------
(defun scratch-make-scratch (&optional arg)
(interactive)
(progn
; "*scratch*" を作成して buffer-list に放り込む
(set-buffer (get-buffer-create "*scratch*"))
(funcall initial-major-mode)
(erase-buffer)
(when (and initial-scratch-message (not inhibit-startup-message))
(insert initial-scratch-message))
(or arg (progn (setq arg 0)
(switch-to-buffer "*scratch*")))
(cond ((= arg 0) (message "*scratch* is cleared up."))
((= arg 1) (message "another *scratch* is created")))
)
)

(defun scratch-buffer-name-list ()
(mapcar (function buffer-name) (buffer-list))
)

;;--------------------------------------------------
;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
;;--------------------------------------------------
(add-hook 'after-save-hook
(function
(lambda ()
(unless (member "*scratch*" (scratch-buffer-name-list))
(scratch-make-scratch 1)
)
)
)
)

;;--------------------------------------------------
;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
;;--------------------------------------------------
(add-hook 'kill-buffer-query-functions
(function
(lambda ()
(if (string= "*scratch*" (buffer-name))
(progn (scratch-make-scratch 0) nil)
t
)
)
)
)

;;--------------------------------------------------
;; 深さ制限設定
;;--------------------------------------------------
(setq max-lisp-eval-depth 1000)

;;--------------------------------------------------
;; リージョン内を置換
;;--------------------------------------------------
(delete-selection-mode t)

;;--------------------------------------------------
;; 自動折り返しの無効
;;--------------------------------------------------
(setq-default truncate-lines t)

;;--------------------------------------------------
;; C-v,M-vでスクロールしたときに、ポイントの位置を維持する
;;--------------------------------------------------
(setq scroll-preserve-screen-position t)

;;--------------------------------------------------
;; 自動セーブ無効
;;--------------------------------------------------
(setq-default suto-save-default nil)

;;--------------------------------------------------
;; 自動バックアップの無効
;;--------------------------------------------------
(setq make-backup-files nil)

;;--------------------------------------------------
;; shell の指定
;;--------------------------------------------------
(setq explicit-shell-file-name "/bin/bash")

;;--------------------------------------------------
;; kill-ringをクリアー
;;--------------------------------------------------
(defun kill-ring-clear ()
(interactive)
(save-excursion
(setq kill-ring nil)
)
)

;;---------------------------------------
;; w3m
;;---------------------------------------
;(add-to-list 'load-path "/usr/share/emacs/site-lisp/w3m/")
;(require 'w3m-load)
;(setq w3m-home-page "http://www.google.co.jp/")
;(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGIN." t)
;(setq w3m-search-default-engin "google-ja")

;;---------------------------------------
;; バッファリスト
;;---------------------------------------
;(global-set-key "\C-x\C-b" 'bs-show) ; ファイルのみ
;(global-set-key "\C-x\C-b" 'buffer-menu) ; ファイルとフォルダ
(global-set-key "\C-x\C-b" 'ibuffer) ; ファイルとフォルダのカラー表示

;;---------------------------------------
;; grepのオプション
;;---------------------------------------
(setq grep-command "grep -nHrie ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; 画面の設定
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;--------------------------------------------------
;; yes or no を y or n にする
;;--------------------------------------------------
(fset 'yes-or-no-p 'y-or-n-p)

;;--------------------------------------------------
;; カーソル行に色をつける
;;--------------------------------------------------
(global-hl-line-mode)
(hl-line-mode 1)
(copy-face 'highlight 'cursor-line-color)
(set-face-background 'cursor-line-color "#303030")
(setq hl-line-face 'cursor-line-color)

;;--------------------------------------------------
;; region の色
;;--------------------------------------------------
(setq transient-mark-mode t)
(set-face-background 'region "#303000")

;;--------------------------------------------------
;; 文字列 の色
;;--------------------------------------------------
(set-face-foreground font-lock-string-face "#ff5fff")

;;--------------------------------------------------
;; diredのdirectory等の色
;;--------------------------------------------------
(set-face-foreground 'font-lock-function-name-face "#9932cc")

;;--------------------------------------------------
;; 対応する括弧間の強調
;;--------------------------------------------------
(show-paren-mode t)
(setq show-paren-style 'expression) ;カッコ内の色を変える
(set-face-attribute 'show-paren-match nil :background 'unspecified)

;;--------------------------------------------------
;; 起動時の画面はいらない
;;--------------------------------------------------
(setq inhibit-startup-message t)

;;--------------------------------------------------
;; 時刻をモードラインに表示
;;--------------------------------------------------
(setq display-time-24hr-format t)

;;--------------------------------------------------
;; 時刻の書式をAM/PMではなく24時間表示にする
;;--------------------------------------------------
(setq display-time-day-and-date t) ; 時刻の書式に日付を追加する
(display-time)

;;--------------------------------------------------
;; メニューバー非表示
;;--------------------------------------------------
(menu-bar-mode -1)

;;--------------------------------------------------
;; ツールバー非表示
;;--------------------------------------------------
; (tool-bar-mode -1)

;;--------------------------------------------------
;; 総行数表示
;;--------------------------------------------------
(setcar mode-line-position '(:eval (format "MAX-L%d" (count-lines (point-max) (point-min)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; 文字化け問題
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let
(
(my-translation-table
(make-translation-table-from-alist '((#x301c . #xff5e)))
)
)
(mapc
(lambda
(coding-system)
(coding-system-put coding-system :decode-translation-table my-translation-table)
(coding-system-put coding-system :encode-translation-table my-translation-table)
)
'(utf-8 cp932 utf-16le)
)
)

(setq skk-rom-kana-rule-list
'(("z-" nil "～"))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;
;; ショートカットキー
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;--------------------------------------------------
;; C-hでバックスペース
;;--------------------------------------------------
(global-set-key (kbd "C-h") 'delete-backward-char) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (ztree))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
