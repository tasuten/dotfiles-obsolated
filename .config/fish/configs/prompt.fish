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
  set rpompt $rpompt (__git_rprompt)
  set rpompt $rpompt (prompt_pwd)
  echo -n $rpompt (set_color normal)
end

function __git_rprompt
  set -l branch (git rev-parse --abbrev-ref HEAD ^/dev/null)

  echo -n $branch
  set_color normal
end
