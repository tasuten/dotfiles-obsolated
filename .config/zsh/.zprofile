if [[ -d "$ZDOTDIR/$(uname)" ]]; then
  source "$ZDOTDIR/$(uname)"/*.zsh
fi

export RBENV_ROOT=$XDG_DATA_HOME/rbenv

if [[ -d $RBENV_ROOT ]]; then
  eval "$(rbenv init -)"
fi

