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
zstyle ':zle:*' word-chars ' _-=/;@'
zstyle ':zle:*' word-style unspecified

# 1: 補完の時にVimで言うsmartcaseにする
# 2: 例えばs.vでs*.v*なファイルを補完出来るようにする （『zshの本』P.154）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|.=*'

# sudoでも以下のディレクトリ内のコマンドは補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# ../とした時に今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

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
# Ctrl-F, Ctrl-Bでワード単位移動
bindkey '^F' forward-word
bindkey '^B' backward-word
# Ctrl-Dでforward方向にワード削除
bindkey '^D' kill-word
# backward-kill-wordはEmacsキーバインドではCtrl-Wに割当済み
# Shift-Tabで補完一覧候補を逆順に辿る
bindkey "^[[Z" reverse-menu-complete
# Ctrl-R/Sの検索でワイルドカードなどを使えるように
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward


# PROMPT変数で変数展開などを行う
setopt prompt_subst
# 今のプロンプト以外のRPROMPTを消す
setopt transient_rprompt
# ビープを鳴らさない
setopt no_beep
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
# **/*.cのようなパターンを**.cと書けるようにする
setopt glob_star_short
# スペルチェック
setopt correct
# {a-c}や{cba}を a b c に展開する機能を使えるようにする
setopt brace_ccl
# Ctrl-S/Ctrl-Qによるフロー制御を使わないようにする
setopt no_flow_control
# Ctrl-Dでzshを終了しない
setopt ignore_eof
# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
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
# Ubutnuのデフォルトのaliasと同じにした
# -a ドットで始まるファイルも表示する
# -A -aとほぼ同じだが.と..を除外する
# -C 標準出力以外に出力するときでも複数列で表示
# -F ファイルタイプに応じてファイル名に/や@や*をsuffixする
# -l ファイルの詳細情報を表示する
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
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g C='| pbcopy' # クリップボードへコピー

# exit周り
alias q='exit'

# antigen
ADOTDIR=$XDG_DATA_HOME/antigen

source `brew --prefix`/share/antigen/antigen.zsh

# plugin
antigen bundle mollifier/cd-gitroot

# completion
antigen bundle docker
antigen bundle vagrant

# theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen apply

alias cdu='cd-gitroot'
compdef cdu=cd-gitroot

# tmuxを自動で起動
if [[ "$TMUX" = "" ]]; then
  tmux
fi

