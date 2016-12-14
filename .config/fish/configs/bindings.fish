# fishのキーバインド

function fish_user_key_bindings
  # Ctrl-F,  Ctrl-Bでワード単位移動
  bind \cf forward-word
  bind \cb backward-word
  # Ctrl-D, Ctrl-Wでワード削除
  bind \cw backward-kill-word
  bind \cd kill-word
end

