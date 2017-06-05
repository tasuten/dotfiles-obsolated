if [[ -d "$ZDOTDIR/$(uname)" ]]; then
  source "$ZDOTDIR/$(uname)"/profile/*.zsh
fi

export RBENV_ROOT=$XDG_DATA_HOME/rbenv

if [[ -d $RBENV_ROOT ]]; then
  eval "$(rbenv init -)"
fi

export OPAM_ROOT=$XDG_DATA_HOME/opam
if [[ -d $OPAM_ROOT ]]; then
  eval "$(opam config env --root=$OPAM_ROOT)"
fi


export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export CARGO_HOME=$XDG_DATA_HOME/cargo
export PATH=$CARGO_HOME/bin:$PATH

export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$XDG_DATA_HOME/go
export PATH=$PATH:$GOPATH/bin


