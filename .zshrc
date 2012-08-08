# 環境変数は原則~/.zprofileの方に書いた

# lsのディレクトリの色が黒バックの場合デフォルトでは青で見難いのでシアンに
export LSCOLORS=gxfxcxdxbxegedabagacad
# 補完の方の色はこっち
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# 補完の時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# sudo でも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# zshの補完関数ファイルの保存先
fpath=(~/.zsh/functions $fpath)

# http://d.hatena.ne.jp/tsaka/20060819/1162739565 も参考にするといいかも

# 以下http://blog.blueblack.net/item_204 をベースにした
# zsh使用に際して1つ注意。.profileが読み込まれないので
# .zprofileにmv又はcp
export LANG=ja_JP.UTF-8

## 履歴の保存先
HISTFILE=$HOME/.zsh-history
## メモリに展開する履歴の数
HISTSIZE=100000
## 保存する履歴の数
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit
compinit

## コアダンプサイズを制限
limit coredumpsize 102400
## 出力の文字列末尾に改行コードが無い場合でも表示
#unsetopt promptcr
## Emacsライクキーバインド設定
bindkey -e

## 色を使う
setopt prompt_subst
## ビープを鳴らさない
setopt nobeep
## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
## 補完候補を一覧表示
setopt auto_list
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## cd 時に自動で push
setopt auto_pushd
## 同じディレクトリを pushd しない
setopt pushd_ignore_dups
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## TAB で順に補完候補を切り替える
setopt auto_menu
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## =command を command のパス名に展開する
setopt equals
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit
## ヒストリを共有
setopt share_history
## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
#eval `dircolors` # command not foundになるのでコメントアウト
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## ディレクトリ名だけで cd
setopt auto_cd
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## スペルチェック
setopt correct
## {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
## Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control
## コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
## コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## history (fc -l) コマンドをヒストリリストから取り除く。
# setopt hist_no_store
## 補完候補を詰めて表示
setopt list_packed
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
# aliasを貼ってる場合の補完を適時うまいことやってくれる
setopt complete_aliases
# 補完時に濁点・半濁点を<3099>、<309a>のようにさせない
setopt combining_chars

# プロンプト
# http://blog.blueblack.net/item_207 参考
# プロンプトの設定
autoload colors
colors
# 太字シアンの文字に、アンダーバーを付ける
PROMPT="%U%B%F{cyan}%m: %n%(!.#.$)%u %f%b"
PROMPT2="%_> "
SPROMPT="correct: %R -> %r [nyae]? "
# RPROMPT="[%~]"
# RPROMTは
# git のブランチ名 *と作業状態* を zsh の右プロンプトに表示＋ status に応じて色もつけてみた - Yarukidenized:ヤルキデナイズド
# http://d.hatena.ne.jp/uasi/20091025/1256458798
# をsubmoduleで
source ~/dotfiles/214109/gistfile1.txt

# ターミナルのタイトル
#  http://journal.mycom.co.jp/column/zsh/002/index.html 参考
case "${TERM}" in
  kterm*|xterm|xterm-256color)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}: ${PWD}\007"
    }
    ;;
esac

# 以下alias周り

# デフォルトのエディタをmacvim-kaoriyaに
# vim/gvimでmacvim-kaoriyaを起動するようにする
export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias gvim='env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app "$@"'

# javacなんかで文字化けするのでUTF-8を指定して実行するようにalias
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

# opencでopen .（カレントディレクトリを開く）
alias openc='open .'
# emacsコマンドでCarbon Emacsを起動
alias emacs='open -a Emacs'
# 他にもGUIなソフトウェアをいくつかコマンドラインでも起動できるように
alias coteditor='open -a CotEditor'
alias firefox='open -a Firefox'

# lsで色をつける
alias ls='ls -G'

# diffの代わりにcolordiffを使う。Homebrewでインストール可能
# ついでにunified形式で出力するようにする
alias diff='colordiff -u'
# lessやmoreを色付きで表示してくれるように
export LESS='-R'
export MORE='-R'

# grepに色を付ける
# --color=alwaysにしないのは、grepコマンドを使用しているスクリプトなんかで
# 困るかもしれないそうなので
# http://d.hatena.ne.jp/bubbles/20081210/1228918665
export GREP_OPTIONS='--color=auto'
# 色はシアン
export GREP_COLOR='00;36'

# manがデフォルトでは英語版なので日本語のjmanをインストールしてalias
alias man='jman'

# cdがpushdなのでpopdをpdにalias
alias pd='popd'

# git周りのalias
# gitレポジトリのルートに移動する
alias cd_git='cd $(git rev-parse --show-toplevel)'
# 短縮コマンド
# gstでgit statusを短縮表示(-s)かつブランチ名を表示(-b)し
# stashのリストも表示
alias gst='git status -s -b && git stash list'
alias gca='git commit -a'
alias gdf='git diff --word-diff'
alias glo='git log --oneline --decorate'

# ls関連エイリアス
# Ubutnuのデフォルトのaliasと同じにした
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -A'
# ついでにtypo補正も(;s -> ls)
alias s='ls'

# グローバルエイリアス
# 例: ls | grep word -> ls G word
alias -g L='| less'
alias -g M='| more'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g UTFM='| iconv -f UTF-8-MAC -t UTF-8'
# UTFMフィルタを利用した、UTF-8-MAC向けls。
# zshの方はsetopt combining_charsで行けるけどtmuxの方が今のところ無理そうなので
function lsmac(){
  ls $@ UTFM
}

# vimrc/zshrc/zprofileで当該ファイルを編集
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'
alias zprofile='vim ~/.zprofile'

# zshのcorrectのお節介を少し改善
# coreutilsパッケージのGNU版lsとか向け
# 一応使いそうなのだけ。また適時追加
alias gcat="nocorrect gcat"
alias gcp="nocorrect gcp"
alias gls="nocorrect gls"
alias gmv="nocorrect gmv"
# お節介のここまで

# alias周りここまで


# 全文検索のfindをzshrcに登録 - La Faïence
# http://d.hatena.ne.jp/famnet/20110723/fulltext_find_function_in_zshrc
# search dir/ hogeみたく使う
function search() {
  find "$1" -print | xargs grep "$2"
}

# cdd を tmux, bash, multi session +α に対応した - カワイイはつくれる
# http://m4i.hatenablog.com/entry/2012/01/26/064329
autoload -Uz compinit
compinit
. ~/bin/cdd

chpwd() {
  _cdd_chpwd
}

# tmuxを自動で起動
if [ "$TMUX" = "" ]; then
  tmux
fi

