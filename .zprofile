# Homebrewでインストールした最新版がある場合、システム標準のものではなく
# Homebrewで入れた方を優先して使うようにする
export PATH=/usr/local/bin:$PATH

# w3mのスタートページをwww.google.co.jpに
# W3M FAQ http://homepage2.nifty.com/aito/w3m/FAQ.html 参照
export WWW_HOME='www.google.co.jp'

# GMT(http://gmt.soest.hawaii.edu/ )向け設定
# ※Greenwich Mean Timeのことではない
export NETCDFHOME=/usr/local/netcdf3.6.x
export GMTHOME=/usr/local/gmt
export PATH=$GMTHOME/bin:$PATH
export MANPATH=$GMTHOME/man:$MANPATH

# MacTeX
export TEXBIN=/usr/texbin
export PATH=$TEXBIN:$PATH

# rbenv
eval "$(rbenv init -)"

# ~/binにパスを通す
export PATH=$HOME/bin:$PATH

