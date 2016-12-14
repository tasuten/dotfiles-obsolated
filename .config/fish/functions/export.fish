# exportする環境変数

# 基本的なこと
set -x LANG ja_JP.UTF-8
set -x EDITOR /Applications/MacVim.app/Contents/MacOS/Vim

# パスを通す
# Homebrew
set -Ux PATH /usr/local/bin $PATH
set -Ux PATH /usr/local/sbin $PATH

# rlwrap
set -x RLWRAP_HOME $HOME/.rlwrap/

# MacTeX
set -x TEXBIN /Library/TeX/texbin
set -x PATH $TEXBIN $PATH
# TeX関連ファイルの置き場所
set -x TEXINPUTS $TEXINPUTS $HOME/.TeX/tex
set -x BIBINPUTS $BIBINPUTS $HOME/.TeX/bibtex/bib
set -x BSTINPUTS $BSTINPUTS $HOME/.TeX/bibtex/bst

# ~/bin/
set -x PATH $HOME/bin $PATH

# 各ソフトウェアの設定
# lessが色付きテキストを表示出来るようにする
set -x LESS '-R'
# grepでヒット部分をシアンで
set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '00;36'
# w3m
set -x WWW_HOME 'www.google.co.jp'

