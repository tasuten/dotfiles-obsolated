# aliasまわり

# MacVim-Kaoriya
alias vim 'env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
alias gvim 'env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app'
alias g 'git'


# opencでopen .（カレントディレクトリを開く）
alias openc 'open .'

# ls関連エイリアス
# Ubutnuのデフォルトのaliasと同じにした
# -a ドットで始まるファイルも表示する
# -A -aとほぼ同じだが.と..を除外する
# -C 標準出力以外に出力するときでも複数列で表示
# -F ファイルタイプに応じてファイル名に/や@や*をsuffixする
# -l ファイルの詳細情報を表示する
alias ll 'ls -alF'
alias l 'ls -CF'
alias la 'ls -A'
# ついでにtypo補正も(;s -> ls)
alias s 'ls'

# diffの代わりにcolordiffを使う。Homebrewでインストール可能
# ついでにunified形式で出力するようにする
alias diff 'colordiff -u'

# ag(the_silver_searcher)の設定
# 隠しファイル(.vimrc等)を検索対象に入れるが、.git/は無視する
alias ag 'ag --hidden --ignore .git/'

# exit
alias q 'exit'

# javacなんかで文字化けするのでUTF-8を指定して実行するようにalias
alias javac 'javac -J-Dfile.encoding=UTF-8'
alias java 'java -Dfile.encoding=UTF-8'
alias javadoc 'javadoc -J-Dfile.encoding=UTF-8'
alias jar 'jar -J-Dfile.encoding=UTF-8'

# Gaucheのgoshをrlwrap経由で起動するようにする
# なお、-bで設定する単語の区切り文字の設定がデフォルトだと
# Schemeの文法では少し困るので明示的に指定
alias gosh 'rlwrap -b "(){}[],#\";| " gosh'

