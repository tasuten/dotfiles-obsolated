# 環境変数は原則~/.zprofileの方に書いた

# lsのディレクトリの色が黒バックの場合デフォルトでは青で見難いのでシアンに
export LSCOLORS=gxfxcxdxbxegedabagacad
# 補完の方の色はこっち
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# lsに色を付ける（-G指定と同じ）
export CLICOLOR=true

# 1: 補完の時にVimで言うsmartcaseにする
# 2: 例えばs.vでs*.v*なファイルを補完出来るようにする （『zshの本』P.154）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|.=*'

# sudoでも以下のディレクトリ内のコマンドは補完
# 大抵これで事足りるがこれ以外のPATHにあるものも補完して欲しい場合以下参照
# http://blog.geta6.net/post/60605922314/zstyle-command-path-path
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
# ../とした時に今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..


export LANG=ja_JP.UTF-8

# 履歴の保存先
HISTFILE=$HOME/.zsh-history
# メモリに展開する履歴の数
HISTSIZE=100000
# 保存する履歴の数
SAVEHIST=100000

# 補完機能の強化
autoload -U compinit
compinit

# コアダンプサイズを制限
limit coredumpsize 102400
# 出力の文字列末尾に改行コードが無い場合でも表示
# unsetopt promptcr
# Emacsライクキーバインド設定
bindkey -e
# Ctrl-F, Ctrl-Bでワード単位
bindkey '^F' forward-word
bindkey '^B' backward-word
# Ctrl-Dでワードを削除
bindkey '^D' kill-word
# Shift-Tabで補完一覧候補を逆順に辿る
bindkey "^[[Z" reverse-menu-complete
# Ctrl-R/Sの検索でワイルドカードなどを使えるように
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


# PROMPT変数で変数展開などを行う
setopt prompt_subst
# ビープを鳴らさない
setopt nobeep
# 内部コマンドjobsの出力にPIDを含める
setopt long_list_jobs
# 補完候補一覧でファイルの種別をマーク表示
setopt list_types
# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
# 補完候補を一覧表示
setopt auto_list
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# cd時に自動でpushd
setopt auto_pushd
# 同じディレクトリをpushdしない
setopt pushd_ignore_dups
# 拡張グロブを使う
# ざっくり言えばzshのファイル名補完とかでパターンとか使えるようになる
setopt extended_glob
# [TAB]で順に補完候補を切り替える
setopt auto_menu
# ヒストリを拡張フォーマットで保存
setopt extended_history
# =commandをcommandのフルパスに展開する
setopt equals
# --prefix=/usrなどの=以降もファイル名補完
setopt magic_equal_subst
# ヒストリを呼び出してから実行する間に一旦編集可能に
setopt hist_verify
# ファイル名の数字は辞書順ではなく数値的にソート
setopt numeric_glob_sort
# 出力時8ビットを通す
setopt print_eight_bit
# 複数のzsh間でヒストリを共有
# ただし、ヒストリを読み込むタイミングはプロンプトが出る時
# なのでプロンプト出したまま放置してると古いまま
setopt share_history
# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
# 補完候補の色づけ
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# ディレクトリ名だけでcd
setopt auto_cd
# 変数名の補完で空白や}を後ろに補う
# ただしその直後の入力が:や}など変数名の直後に来るものなら
# その空白を削除して:や}をそこに入力
setopt auto_param_keys
# ディレクトリ名の補完で末尾の/を自動的に付加し、次の補完に備える
setopt auto_param_slash
# ↑でスラッシュが補完された後、;やスペースを入力したら自動的にそのスラッシュを消す
setopt auto_remove_slash
# スペルチェック
setopt correct
# {a-c}や{cba}を a b c に展開する機能を使えるようにする
setopt brace_ccl
# Ctrl-S/Ctrl-Qによるフロー制御を使わないようにする
setopt no_flow_control
# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# history (fc -l) コマンドをヒストリリストから取り除く。
# setopt hist_no_store
# 補完候補を詰めて表示
setopt list_packed
# aliasを貼ってる場合の補完を適時うまいことやってくれる
setopt complete_aliases
# 補完時に濁点・半濁点を<3099>、<309a>のようにさせない
setopt combining_chars
# パスを重複登録させない
typeset -U path cdpath fpath manpath
# zshのビルトインコマンドのr（直前に実行したコマンドを実行）を無効化
disable r

# zplug, plugin manager
source ~/.zplug/zplug

# plugin config
# z
# zは_Z_CMDをスクリプト中で参照して設定するので、
# loadより前に書く必要がある
# zの代わりにより打ちやすいjキーに
export _Z_CMD=j
# 補完関数を有効にする
compctl -U -K _z_zsh_tab_completion "$_Z_CMD"

# commands
zplug 'b4b4r07/zplug'
zplug 'rupa/z', of:z.sh
zplug 'mollifier/cd-gitroot'
# completion
zplug 'tpope/1175742', from:gist

# zplugここまで
zplug load


# プロンプト
autoload colors
colors
# 太字(%B %b)で青色(%F{blue} %f)、プロンプトは$ のみ
# （正確にはrootなら# になるが、OS Xの場合rootは/bin/shなので無問題）
PROMPT="%B%F{blue}%(!.#.$)%f%b "
PROMPT2="%_> "
SPROMPT="correct: %R -> %r [nyae]? "
source ~/dotfiles/git_current_branch.zsh
# RPROMPTの右辺はシングルクォーテーションにしないと
# ``が展開されてしまい.zshrcを読み込んだタイミングでの
# git-current-branchのままになってしまう
RPROMPT='[`git-current-branch`%~]'

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
alias javadoc='javadoc -J-Dfile.encoding=UTF-8'
alias jar='jar -J-Dfile.encoding=UTF-8'

# opencでopen .（カレントディレクトリを開く）
alias openc='open .'

# diffの代わりにcolordiffを使う。Homebrewでインストール可能
# ついでにunified形式で出力するようにする
alias diff='colordiff -u'
# lessやmoreを色付きで表示してくれるように(-R)
export LESS='-R'
export MORE='-R'

# grepに色を付ける
# --color=alwaysにしないのは、grepコマンドを使用しているスクリプトなんかで
# 困るかもしれないそうなので
# http://d.hatena.ne.jp/bubbles/20081210/1228918665
export GREP_OPTIONS='--color=auto'
# 色はシアン
export GREP_COLOR='00;36'

# ag(the_silver_searcher)の設定
# 隠しファイル(.vimrc等)を検索対象に入れるが、.git/は無視する
alias ag='ag --hidden --ignore .git/'

# git周りの短縮コマンド
# gstでgit statusを短縮表示(-s)かつブランチ名を表示(-b)し
# stashのリストも表示
alias gst='git status -s -b && git stash list'
alias gca='git commit -a'
alias gdf='git diff --word-diff'

# ls関連エイリアス
# Ubutnuのデフォルトのaliasと同じにした
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -A'
# ついでにtypo補正も(;s -> ls)
alias s='ls'

# グローバルエイリアス
# グローバルエイリアスとは、
# コマンドライン中のどの位置でも単語として独立していれば
# 適用される。なお、\でエスケープ出来る
# 例: ls | grep word -> ls G word
alias -g L='| less'
alias -g M='| more'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g C='| pbcopy' # クリップボードへコピー

# exit周り
alias q='exit'
alias quit='exit'

# alias周りここまで

# cdd を tmux, bash, multi session +α に対応した - カワイイはつくれる
# http://m4i.hatenablog.com/entry/2012/01/26/064329
autoload -Uz compinit
compinit
. ~/bin/cdd

chpwd() {
  _cdd_chpwd
}

# tmuxを自動で起動
if [[ "$TMUX" = "" ]]; then
  tmux
fi

