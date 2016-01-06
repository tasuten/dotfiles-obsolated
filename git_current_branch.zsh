# gitレポジトリの状況に応じて色を変えてブランチ名を表示
# これをベースにした: https://gist.github.com/uasi/214109
# なお、プロンプトに表示する場合setopt prompt_subst必須

function git-current-branch {

  local branch_name status_message color

  # gitワークツリー内かどうか。そうで無ければ何も返さない
  # このコマンドはワークツリー内なら'true'、
  # .git/内などワークツリー外なら'false'を返して、
  # .gitレポジトリ外ならエラーメッセージを吐いて死ぬ
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]];
  then
    return
  fi

  # ブランチ名
  # エラーメッセージは無視
  branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

  # ステータス
  status_message=$(git status 2> /dev/null)

  if [[ $status_message =~ 'nothing to commit' ]]; then # clean
    color='green'
  elif [[ $status_message =~ 'nothing added' ]]; then
    # レポジトリが追跡するファイルはcleanだが
    # untrackedなファイルがある
    color='yellow'
  else
    # その他（cleanじゃない）
    color='red'
  fi

  # [master ~/]みたいにする予定なので最後にスペース
  echo "%F{$color}$branch_name%f "
}

