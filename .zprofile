export LANG=ja_JP.UTF-8
export EDITOR=/usr/local/bin/vim

# Homebrew
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# XDG Base Directoryを明示
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export RLWRAP_HOME=$XDG_DATA_HOME/rlwrap

# MacTeX
export TEXBIN=/Library/TeX/texbin
export PATH=$TEXBIN:$PATH
# TeX関連ファイルの置き場所
export TEXINPUTS=$TEXINPUTS:$HOME/.TeX/tex
export BIBINPUTS=$BIBINPUTS:$HOME/.TeX/bibtex/bib
export BSTINPUTS=$BSTINPUTS:$HOME/.TeX/bibtex/bst

# rbenv
eval "$(rbenv init -)"

export PATH=$HOME/bin:$PATH

