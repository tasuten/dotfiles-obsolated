set directory=~/.vim/tmp/swap
set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo
set undofile

" Backspaceをちょっと賢く。インデントとかも消せるように
set backspace=indent,eol,start

" 常に大文字小文字を区別して検索（置換時の検索等含む）
set noignorecase
set nosmartcase

set expandtab

set autoindent
set smartindent

set softtabstop=2
set shiftwidth=2

" <C-p><C-n>の補完でincludeしたファイル内の単語も
" 補完されるのが邪魔だったのでそうしないように
set complete-=i

" コマンドライン補完。最長共通部分を補完しつつ候補をstatuslineに表示した後、
" 候補を順に回る
set wildmenu
set wildmode=longest:full,full

" 最後の行を出来る限り表示する（@のように略さない）
set display=lastline

" 「Vimを使ってくれてありがとう」が消えない問題
set notitle

" タブを可視化
set list
set listchars=tab:»\ ,

" 行番号を表示
set number

" カーソルがある行をハイライト
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

