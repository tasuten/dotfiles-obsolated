scriptencoding utf-8

" Ref: http://rbtnn.hateblo.jp/entry/2014/11/30/174749
augroup vimrc
  autocmd!
augroup END

language message C

set directory=~/.vim/tmp/swap
set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo
set undofile

set backspace=indent,eol,start

" case-sensitive search
set noignorecase
set nosmartcase

set expandtab

set autoindent
set smartindent

set softtabstop=2
set shiftwidth=2

set complete-=i

" コマンドライン補完で
" 最長共通部分を補完しつつ候補をstatuslineに表示した後、候補を順に回る
set wildmenu
set wildmode=longest:full,full

" 最後の行を出来る限り表示する（@のように略さない）
set display=lastline

" 「Vimを使ってくれてありがとう」が消えない問題
set notitle

set list
set listchars=tab:»\ ,

set number

set cursorline

" showcmdは個人的には画面に頻繁にちらつくのが気に入らなかったので
set noshowcmd

" Vim8.0で追加されたオプション群
if v:version >= 800
  " 折り返し行をインデントして表示
  set breakindent
  " emojiは全角幅
  set emoji
  " True Color
   set termguicolors
   let &t_8f = "\x1b[38;2;%lu;%lu;%lum"
   let &t_8b = "\x1b[48;2;%lu;%lu;%lum"
endif

" ウィンドウ分割で上や左にではなく右や下に開くように
set splitright
set splitbelow

" >や<をshiftwidthの倍数に丸めるようにする
set shiftround

" USキーボードでは:が押しにくいので;と入れ替え
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
command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
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

filetype on
filetype plugin on
filetype indent on

" TeXは全てLaTeXと見做す
let g:tex_flavor = 'latex'
" TeXのConcealを無効化
let g:tex_conceal = ''

" Vimファイルでの行継続の\の位置を指定
let g:vim_indent_cont = 0

" gitのコミットメッセージ編集時にDでdiffをプレビュー
autocmd vimrc FileType gitcommit nnoremap <buffer> D :DiffGitCached<CR>
autocmd vimrc FileType git nnoremap <buffer> D :q<CR>

" Vimでshebang付ファイルを保存時に実行権限を自動で付加する
" http://d.hatena.ne.jp/spiritloose/20060519/1147970872 より
autocmd vimrc BufWritePost * :call AddExecmod()
function! AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) ==# '#!'
    call system('chmod +x '. expand('%'))
  endif
endfunction

" vim-plug

call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'morhetz/gruvbox'

call plug#end()

" vim-plug
" アップデートウィンドウは下に開く
let g:plug_window = 'belowright new'

" ユーザ定義のハイライトグループ
" ZenkakuSpace: 全角スペース
" WhitespaceEOL: 行末のスペース
autocmd vimrc ColorScheme * call s:my_highlights()
function! s:my_highlights()
  highlight ZenkakuSpace ctermfg=124 guifg=#cc241d cterm=underline gui=underline
  highlight WhitespaceEOL ctermbg=124 guibg=#cc241d
  let w:m1 = matchadd('ZenkakuSpace', '　')
  let w:m2 = matchadd('WhitespaceEOL', '\s\+$')
endfunction

colorscheme gruvbox

