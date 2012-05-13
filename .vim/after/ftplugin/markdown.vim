" どうやら$VIMRUNTIE(/Applications/MacVim.app/Contents/Resources/vim/runtime)の中に
" Markdownのsyntaxファイルがあって、その中でHTMLファイルの設定を読み込んでるらしく
" 設定ファイルの読み込み順の関係で
" MarkdownでもHTMLの時の設定が適用されてしまうらしい。
" ので、Markdownの設定は~/.vim/after/ftpluginに突っ込んでる

" タブ関連
setlocal expandtab
setlocal shiftwidth=4
setlocal softtabstop=4

" スマートインデント
setlocal autoindent
setlocal smartindent

