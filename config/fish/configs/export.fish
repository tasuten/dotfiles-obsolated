# exportする環境変数

# 基本的なこと
set -x LANG ja_JP.UTF-8
set -x EDITOR /Applications/MacVim.app/Contents/MacOS/Vim

# XDG Base Directoryを明示
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_DATA_DIRS /usr/local/share /usr/share
set -x XDG_CONFIG_DIRS /etc/xdg

# パスを通す
# Homebrew
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH

# rustup
set -x PATH $HOME/.cargo/bin $PATH

# homebrew-file
set -x HOMEBREW_BREWFILE $XDG_DATA_HOME/Brewfile

# rlwrap
set -x RLWRAP_HOME $XDG_DATA_HOME/rlwrap

# MacTeX
set -x TEXBIN /Library/TeX/texbin
set -x PATH $TEXBIN $PATH
# TeX関連ファイルの置き場所
set -x TEXINPUTS "$TEXINPUTS:$HOME/.TeX/tex:"
set -x BIBINPUTS "$BIBINPUTS:$HOME/.TeX/bibtex/bib:"
set -x BSTINPUTS "$BSTINPUTS:$HOME/.TeX/bibtex/bst:"

# ~/bin/
set -x PATH $HOME/bin $PATH

# 各ソフトウェアの設定
# lsの色
set -x LSCOLORS 'gxhxcxdxbxaeagabafacad'
set -x LS_COLORS 'di=36:ln=37:so=32:pi=33:ex=31:bd=30;44:cd=30;46:su=30;41:sg=30;45:tw=30;42:ow=30;43'
# lessが色付きテキストを表示出来るようにする
set -x LESS '-R'
# lesshstファイルを作らない
set -x LESSHISTFILE '-'
# grepでヒット部分をシアンで
set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '00;36'
# w3m
set -x WWW_HOME 'www.google.co.jp'

