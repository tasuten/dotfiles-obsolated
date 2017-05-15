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
  " コンソールでもTrue Colorを使う
   set termguicolors
   let &t_8f = "\x1b[38;2;%lu;%lu;%lum"
   let &t_8b = "\x1b[48;2;%lu;%lu;%lum"
endif

" ウィンドウ分割で上や左にではなく右や下に開くように
set splitright
set splitbelow

" >や<をshiftwidthの倍数に丸めるようにする
set shiftround

