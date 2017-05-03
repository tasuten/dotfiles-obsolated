# aliasまわり

# よく使うコマンド
alias g 'git'
alias b 'brew'


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

# cd-gitroot-fish
alias cdu 'cd-gitroot'

