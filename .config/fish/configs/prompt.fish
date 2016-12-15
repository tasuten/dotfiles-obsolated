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
    set rpompt $rpompt (__git_rprompt)
  end
  set rpompt $rpompt (prompt_pwd)
  echo -n $rpompt (set_color normal)
end

function __git_rprompt
  set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null )
  set -l prompt ''

  if git_is_touched
    set_color red
  else
    set_color green
  end

  set prompt $prompt $branch

  if git_is_detached_head; or [ -n (git_ahead ^/dev/null >/dev/null) ]
    set prompt $prompt '!'
  end

  if git_untracked_files ^/dev/null >/dev/null
    set prompt $prompt '?'
  end

  echo -n $prompt
  set_color normal
end
