#!/bin/bash

# 手動管理
DOTFILES="
bin/
.vimrc
.zshrc
.zprofile
.tmux.conf
.gitconfig
.vim/template/
.vim/snippets/
.vim/ftplugin/
.vim/after/ftplugin/
"

# 環境構築先のルートディレクトリ
# 普通は~/だけどテスト時とかは適宜変更して
ROOT_DIR=$HOME

# dotfilesディレクトリ
# 例えば~/dotfiles
BASE_DIR=$(cd "${0%/*}" || return 1;pwd)

for file in $DOTFILES; do
  file=${file%/} # 末尾に/があれば取り除く

  original="$BASE_DIR/$file"
  symlink="$ROOT_DIR/$file"

  # 存在しないディレクトリの中にsymlinkを作ろうとすると怒られるので
  parent_dir=${symlink%/*}
  if [ ! -d "$parent_dir" ]; then
    mkdir -p "$parent_dir"
  fi

  # 古いリンクがあるなら削除
  if [ -L "$symlink" ]; then
    unlink "$symlink"
  fi

  ln -s "$original" "$symlink"
done

echo "Done Successfully."

