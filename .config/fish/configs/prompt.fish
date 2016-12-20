function fish_prompt -d 'Leftside prompt'
    set -l last_status $status

    set -l prompt ''
    set -e prompt[1]

    # superuser
    if test (id -u) -eq 0 -o $SUDO_USER
        set_color red
        set prompt $prompt '#'
    else
        if test $last_status -eq 0
            set_color blue
        else
            set_color yellow
        end
        set prompt $prompt '$'
    end

    echo -n $prompt (set_color normal)
end


function fish_right_prompt -d 'Rightside prompt'
    set -l rprompt ''
    if git_is_repo
        set rpompt $rpompt (__git_prompt)
    end
    set rpompt $rpompt (prompt_pwd)
    echo -n $rpompt (set_color normal)
end

function __git_prompt
    set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null )
    set -l prompt ''

    # working treeと最新のコミットの間に差異がある場合、赤色
    # これはuntrackedなファイルがある場合も含む
    if git_is_touched
        set_color red
    else
        set_color green
    end

    set prompt $prompt $branch

    # リモートブランチが存在し、かつahead/behindがある場合
    if git rev-list --left-right @...'@{u}' ^/dev/null | grep "^[<>]" >/dev/null
        set prompt $prompt '!'
    end

    if git_untracked_files ^/dev/null >/dev/null
        set prompt $prompt '?'
    end

    echo -n $prompt
    set_color normal
end

