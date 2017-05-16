export LANG=ja_JP.UTF-8
export EDITOR=vim

# XDG Base Directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg


export RLWRAP_HOME=$XDG_DATA_HOME/rlwrap

if [[ -d $HOME/.rbenv ]]; then
  eval "$(rbenv init -)"
fi

export PATH=$HOME/bin:$PATH

