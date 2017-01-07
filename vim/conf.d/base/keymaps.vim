" USキーボードでは:がShift-;で押しにくいので;と入れ替え
noremap ; :
noremap : ;

" カーソル移動を物理行でなくレイアウト行で
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

" 挿入モードでEmacsライクなキーバインド
inoremap <C-a> <C-o>0
inoremap <C-e> <C-o>$

" カーソルキー（とh, l）で行末-次の行頭の移動を可能に
set whichwrap=b,s,[,],<,>
nnoremap h <Left>
nnoremap l <Right>

" vvで行単位選択ビジュアルモードに入る。元のVが打ちづらかったので
nnoremap vv V

" 検索結果を画面中央に表示するようにする
noremap n nzz
noremap N Nzz
noremap * *zz
noremap # #zz

" x, Xで削除した文字はレジスタに突っ込ませないようにする
nnoremap x "_x
nnoremap X "_X

" QuickFixの開閉のトグル
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
command -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists('g:qfix_win') && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen
    let g:qfix_win = bufnr('$')
  endif
endfunction
nnoremap <silent> <Space>q :QFixToggle<CR>

" <ESC>と誤爆しやすい<F1>でヘルプが表示されないように
inoremap <F1> <Nop>
nnoremap <F1> <Nop>

" ZZやZQも確認なしで誤爆のリスクがあるのでnop
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" <ESC>CTRL-Wをi_CTRL-Wに誤爆して挿入データを消してしまうことがあるので
inoremap <C-w> <ESC><C-w>

" 誤爆しやすいq[:/?]関連をQ[:/?]に割り当て
" JISキーボードだとShift押したままだとQ:の際に誤爆しそうなQ*もQ:に
nnoremap Q: <ESC>q:
nnoremap Q* <ESC>q:
nnoremap Q/ <ESC>q/
nnoremap Q? <ESC>q?
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" 同じく誤爆しやすいqq(レジスタqにレコーディング)はいっそ無効化
nnoremap qq <Nop>

" helpをブラウズ時なんかに、
" CTRL-]から戻るのにCTRL-OやCTRL-Tは少し打ちにくいので、
" キー配置が近いCTRL-\に。
" 本当はJISではCTRL-:にしたかったけどそんなキーコードはASCII的に無い
" またUSではCTRL-[にしたかったけどESCと等価なので使えない
nnoremap <C-\> <C-o>

" コマンドラインモードでEmacsライクなキーバインド
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-e> <End>
" http://stackoverflow.com/questions/26310401/
" 既知の問題として、incsearch.vimの/や?では効かないことに注意
cnoremap <C-k> <C-\>e
\getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>

