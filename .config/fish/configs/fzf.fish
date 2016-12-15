function __fzf_z
  set -q FZF_Z_COMMAND
  or set -l FZF_Z_COMMAND "
  __z -l 2>&1 | sed -E 's/^[0-9]+.[0-9]+ +//g'"

  fish -c "$FZF_Z_COMMAND" | __fzfcmd -m $FZF_Z_OPTS | read -la select
  if test ! (count $select) -eq 0
    cd "$select"
  end
  commandline -f repaint
end


