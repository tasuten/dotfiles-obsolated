# zのディレクトリ
function __fzf_z_directories
    set -q FZF_Z_COMMAND
    or set -l FZF_Z_COMMAND "
  __z -l 2>&1 | sed -E 's/^[0-9]+(.[0-9]+)? +//g'"

    fish -c "$FZF_Z_COMMAND" | __fzfcmd $FZF_Z_OPTS | read -la select
    if test (count $select) -ne 0
        cd "$select"
    end
    commandline -f repaint
end

# gitのトラッキング中のファイル
function __fzf_git_trackings
    set __GIT_ROOT_PATH (git rev-parse --show-cdup)
    set -q FZF_GIT_TRACKING
    or set -l FZF_GIT_TRACKING_COMMAND "git ls-files --full-name $__GIT_ROOT_PATH"

    fish -c "$FZF_GIT_TRACKING_COMMAND" | __fzfcmd $FZF_GIT_TRACKING_OPTS | __fzfescape | read -la selects
    if test (count $selects) -ne 0
        vim "$__GIT_ROOT_PATH$selects"
    end
    commandline -f repaint
end

# gitのbranch
function __fzf_git_branches
    set -q FZF_GIT_BRANCH
    or set -l FZF_GIT_BRANCH_COMMAND 'git branch -vv | grep -v "^\*"'

    fish -c "$FZF_GIT_BRANCH_COMMAND" | __fzfcmd $FZF_GIT_TRACKING_OPTS | read -la select
    if test (count $select) -ne 0
        set -l branch  (echo "$select" | cut -d \  -f 1)
        git checkout "$branch"
    end
    commandline -f repaint
end

