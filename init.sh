#!/bin/bash

# when any command returns non-0, exit this script
set -e

die() {
  echo "$@" >&2
  exit 1
}

mkdir_p() {
  local target
  target=$1
  if [[ ! -d $target ]]; then
    mkdir -p "$target"
  fi
}

symlink() {
  local entity link
  entity=$1
  link=$2

  if [[ -L $link ]]; then
    unlink "$link"
    ln -s "$entity" "$link"
  elif [[ -e $link ]]; then
    die "A file already exists at $link"
  else
    local parent
    parent=$(dirname "$link")
    if [[ ! -d "$parent" ]]; then
      mkdir_p "$parent"
    fi
    ln -s "$entity" "$link"
  fi
}

link () {
  local dotfiles root
  dotfiles="$HOME/dotfiles"
  root="$HOME"
  symlink "$dotfiles/$1" "$root/$1"
}

link_d () {
  link "${1/%\/}"
}

dir () {
  mkdir_p "$HOME/$1"
}

link ".config/git/config"
link_d ".config/zsh/"
link ".tmux.conf"
link ".vimrc"
link_d ".vim/ftplugin"
link ".zshenv"

dir ".vim/tmp/swap"
dir ".vim/tmp/backup"
dir ".vim/tmp/undo"
dir ".vim/plugged"
dir ".config" # XDG_CONFIG_HOME
dir ".cache" # XDG_CACHE_HOME
dir ".local/share" # XDG_DATA_HOME
dir ".local/share/zsh"
dir ".local/share/antigen"
dir ".local/share/rlwrap"
dir ".local/share/rbenv"
dir ".local/share/rustup"
dir ".local/share/cargo"
dir ".local/share/go"

unset -f die mkdir_p symlink link dir
