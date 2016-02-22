# Homebrewでインストールした最新版がある場合、システム標準のものではなく
# Homebrewで入れた方を優先して使うようにする
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# w3mのスタートページをwww.google.co.jpに
export WWW_HOME='www.google.co.jp'

# rlwrapの履歴及び補完ファイルの場所を指定
export RLWRAP_HOME=$HOME/.rlwrap

# MacTeX
export TEXBIN=/Library/TeX/texbin
export PATH=$TEXBIN:$PATH

# rbenv
eval "$(rbenv init -)"

# ~/binにパスを通す
export PATH=$HOME/bin:$PATH

