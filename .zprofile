# Homebrewでインストールした最新版がある場合、システム標準のものではなく
# Homebrewで入れた方を優先して使うようにする
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

# w3mのスタートページをwww.google.co.jpに
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

# golang
export GOPATH=$HOME/.go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# ~/binにパスを通す
export PATH=$HOME/bin:$PATH

