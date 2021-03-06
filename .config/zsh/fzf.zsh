function __fzf_edit_git_files () {
  local repo_root target
  repo_root=$(git rev-parse --show-cdup 2>/dev/null) &&
  target=$(git ls-files --full-name $repo_root | fzf) &&
  $EDITOR "$repo_root$target"
}

function __fzf_input_history () {
  print -z $(fc -ln -1000 | fzf --no-sort --tac)
}
zle -N __fzf_input_history

