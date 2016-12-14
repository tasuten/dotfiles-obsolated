# exportする環境変数

# Homebrew
set -Ux PATH /usr/local/bin $PATH
set -Ux PATH /usr/local/sbin $PATH

# w3m
set -x WWW_HOME 'www.google.co.jp'

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

