if [[ -d "$ZDOTDIR/$(uname)" ]]; then
  source "$ZDOTDIR/$(uname)"/profile/*.zsh
fi

export RBENV_ROOT=$XDG_DATA_HOME/rbenv

if [[ -d $RBENV_ROOT ]]; then
  eval "$(rbenv init -)"
fi

export PATH=$HOME/.cargo/bin:$PATH

export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOPATH/bin


