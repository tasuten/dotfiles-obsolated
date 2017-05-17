function eg () { # edit git tracking file
  local repo_root target
  repo_root=$(git rev-parse --show-cdup 2>/dev/null) &&
  target=$(git ls-files --full-name $repo_root | fzf) &&
  $EDITOR "$repo_root$target"
}

function hs () { # input history into command line
  print -z $(fc -ln -50 | fzf)
}

