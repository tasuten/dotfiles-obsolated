for file in ~/.config/fish/configs/*.fish
    source $file
end

test -z $TMUX
and exec tmux

