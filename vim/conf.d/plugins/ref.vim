" ドキュメントを引くキーバインドのプレフィックスを-で統一
" ちなみに元の機能は-で使えるようにしておいた
nnoremap -- -
nnoremap [doc] <Nop>
nmap - [doc]
" _hでVimのhelpを引く
nnoremap [doc]h :<C-u>h<Space>
" ref.vim
nnoremap [doc]r :<C-u>Ref<Space>
nnoremap [doc]m :<C-u>Ref<Space>man<Space>
nnoremap [doc]rr :<C-u>Ref<Space>refe<Space>
nnoremap [doc]er :<C-u>Ref<Space>erlang<Space>
nnoremap [doc]ex :<C-u>Ref<Space>vivi<Space>
