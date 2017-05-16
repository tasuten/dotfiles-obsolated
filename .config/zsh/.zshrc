# coloring
# ls
export LSCOLORS=gxhxcxdxbxaeagabafacad
# completion
export LS_COLORS='di=36:ln=37:so=32:pi=33:ex=31:bd=30;44:cd=30;46:su=30;41:sg=30;45:tw=30;42:ow=30;43'
# colored ls
export CLICOLOR=true
# colored less
export LESS='-R'
# colored grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='00;36' # cyan

# lesshstを作らない
export LESSHISTFILE='-'

# 単語のデリミタを指定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars ' _-=./;@'
zstyle ':zle:*' word-style unspecified

# 1: 補完の時にVimで言うsmartcaseにする
# 2: 例えばs.vでs*.v*なファイルを補完出来るようにする （『zshの本』P.154）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|.=*'

# sudoでも以下のディレクトリ内のコマンドは補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ../とした時に今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

# _から始まる関数、例えばzshの内部関数などを外す
zstyle ':completion:*:functions' ignored-patterns '_*'

# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
# 補完候補の色づけ
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# killも色づけ
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=0;33' # yellow

# メモリに展開する履歴の数
HISTSIZE=100000
# 保存する履歴の数
SAVEHIST=100000
# コアダンプサイズを制限
limit coredumpsize 102400

# 補完機能の強化
autoload -U compinit
compinit

# Emacsライクキーバインド設定
bindkey -e
# Ctrl-F, Ctrl-Bでワード単位移動
bindkey '^F' forward-word
bindkey '^B' backward-word
# Ctrl-D, Ctrl-Wでforward方向にワード削除
bindkey '^D' kill-word
bindkey '^W' backword-kill-word
# Shift-Tabで補完一覧候補を逆順に辿る
bindkey "^[[Z" reverse-menu-complete
# Ctrl-R/Sの検索でワイルドカードなどを使えるように
bindkey '^R' history-incremental-pattern-search-backward


# cd
# ディレクトリ名だけでcd
setopt auto_cd
# pushd
setopt auto_pushd
# 同じディレクトリは重複してpushdしない
setopt pushd_ignore_dups

# completion
# 補完候補を一覧表示
setopt auto_list
# [TAB]で順に補完候補を切り替える
setopt auto_menu
# 変数名の補完で空白やいい感じに後に補う
setopt auto_param_keys
# ディレクトリ名の補完で末尾の/を自動的に付加し、次の補完に備える
setopt auto_param_slash
# auto_param_slashで付いた/をいい感じに削除する
setopt auto_remove_slash
# aliasを貼ってる場合の補完を適時うまいことやってくれる
setopt complete_aliases
# 補完候補を詰めて表示
setopt list_packed
# 補完候補一覧でファイルの種別をマーク表示
setopt list_types

# glob
# {a-c}や{cba}を a b c に展開する機能を使えるようにする
setopt brace_ccl
# 拡張グロブを使う
# ざっくり言えばzshのファイル名補完とかでパターンとか使えるようになる
setopt extended_glob
# 明確な場合はドットから始まるファイルもglobでマッチする
setopt glob_dots
# --prefix=/usrなどの=以降もファイル名補完
setopt magic_equal_subst
# ファイル名の数字は辞書順ではなく数値的にソート
setopt numeric_glob_sort

# History
# ヒストリを拡張フォーマットで保存
setopt extended_history
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能に
setopt hist_verify
# 複数のzsh間でヒストリを共有
setopt share_history

# I/O
# ビープを鳴らさない
setopt no_beep
# スペルチェック
setopt correct
# 補完時に濁点・半濁点を<3099>、<309a>のようにさせない
setopt combining_chars
# Ctrl-S/Ctrl-Qによるフロー制御を使わないようにする
setopt no_flow_control
# Ctrl-Dでzshを終了しない
setopt ignore_eof
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# 出力時8ビットを通す
setopt print_eight_bit

# Job
# 内部コマンドjobsの出力にPIDを含める
setopt long_list_jobs

# Prompt
# PROMPT変数で変数展開などを行う
setopt prompt_subst
# 今のプロンプト以外のRPROMPTを消す
setopt transient_rprompt

# パスを重複登録させない
typeset -U path cdpath fpath manpath

# zshのビルトインコマンドのr（直前に実行したコマンドを実行）を無効化
disable r

# Gaucheのgoshをrlwrap経由で起動するようにする
# なお、-bで設定する単語の区切り文字の設定がデフォルトだと
# Schemeの文法では少し困るので明示的に指定
alias gosh='rlwrap -b "(){}[],#\";| " gosh'

# opencでopen .（カレントディレクトリを開く）
alias openc='open .'

# pdでauto_pushdでpushされた1つ前のディレクトリへ移動
alias pd='popd'

alias g='git'
compdef g=git
alias b='brew'
compdef b=brew

# ls関連エイリアス
alias ll='ls -alF'
alias l='ls -CF'
alias la='ls -A'
# ;s
alias s='ls'

# グローバルエイリアス
# グローバルエイリアスとは、
# コマンドライン中のどの位置でも単語として独立していれば
# 適用される。なお、\でエスケープ出来る
# 例: ls | grep word -> ls G word
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g C='| pbcopy' # クリップボードへコピー

# exit周り
alias q='exit'

# antigen
ADOTDIR=$XDG_DATA_HOME/antigen

source "$(brew --prefix)"/share/antigen/antigen.zsh

# plugin
# cd-gitroot
antigen bundle mollifier/cd-gitroot
alias cdu='cd-gitroot'
compdef cdu=cd-gitroot
# knu/z
antigen bundle knu/z
export _Z_CMD=j
export _Z_DATA=$XDG_DATA_HOME/z

# completion
antigen bundle docker
antigen bundle vagrant

# theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply


# tmuxを自動で起動
if [[ "$TMUX" = "" ]]; then
  tmux
fi

