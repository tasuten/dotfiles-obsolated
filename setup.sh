#!/bin/bash

# 手動管理
DOTFILES=(.vimrc .zshrc .zprofile .tmux.conf .gitconfig .vim/template .vim/snippets .vim/ftplugin .vim/after/ftplugin )

# このディレクトリを原点に環境を構築する
# ので、スクリプトのテストする時はテスト用のディレクトリに変えて
ROOT_DIR=$HOME/

# ディレクトリのシンボリックリンクでその親ディレクトリが無いとエラーるので
if [ ! -e $ROOT_DIR/.vim ]; then
  mkdir $ROOT_DIR/.vim
fi
if [ ! -e $ROOT_DIR/.vim/after ]; then
  mkdir $ROOT_DIR/.vim/after
fi

for file in ${DOTFILES[@]}; do
  ln -s $HOME/dotfiles/$file $ROOT_DIR/$file
done

