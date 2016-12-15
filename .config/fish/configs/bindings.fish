# fishのキーバインド

function fish_user_key_bindings
  # Ctrl-F,  Ctrl-Bでワード単位移動
  bind \cf forward-word
  bind \cb backward-word
  # Ctrl-D, Ctrl-Wでワード削除
  bind \cw backward-kill-word
  bind \cd kill-word

  # zshのglobal alias代わり
  # 指定のキーで指定の文字列を挿入
  # prefixに\cs
  # 一部直感的でないのは他のkeybindとの兼ね合いなど
  bind \cs\cl "commandline -rt '| less'"
  bind \cs\cj "commandline -rt '| head'"
  bind \cs\ck "commandline -rt '| tail'"
  bind \cs\cg "commandline -rt '| grep'"
  bind \cs\cy "commandline -rt '| pbcopy'"

  # fzf
  # prefixに\cx
  bind \cx\cd __fzf_z # z
  bind \cx\cf __fzf_git_tracking
end

