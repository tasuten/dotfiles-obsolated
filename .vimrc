" vim: foldmethod=marker commentstring=\ \"\ %s:

scriptencoding utf-8

" Ref: http://rbtnn.hateblo.jp/entry/2014/11/30/174749
augroup vimrc
  autocmd!
augroup END

language message C

" options{{{

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
set shiftround " }}}

" keymaps{{{

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
\getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR> " }}}

" filetypes{{{
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
endfunction " }}}

" vim-plug{{{

call plug#begin('~/.vim/plugged')

Plug 'tyru/caw.vim'
Plug 'LeafCage/yankround.vim'
Plug 'nishigori/increment-activator'
Plug 'haya14busa/incsearch.vim'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'vim-scripts/matchit.zip'

" text-object
Plug 'kana/vim-textobj-user'
" URL。u
Plug 'mattn/vim-textobj-url'
" surround.vim。囲ってる文字を消したり(ds")変えたり(cs"')、
" 新たに囲んだり(ys<範囲><囲むの>, eg.)yss})
Plug 'tpope/vim-surround'

" ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

" filetypes
Plug 'justmao945/vim-clang', { 'for' : [ 'c', 'cpp' ] }
Plug 'fatih/vim-go', { 'for' : 'go' }
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'racer-rust/vim-racer', { 'for' : 'rust' }
Plug 'spinningarrow/vim-niji', { 'for' : [ 'lisp', 'scheme', 'clojure' ] }

" colorscheme
Plug 'morhetz/gruvbox'

" statusline
Plug 'itchyny/lightline.vim'

call plug#end() " }}}

" 使わない標準プラグインを無効化{{{
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1 " }}}

" vim-plug setting {{{
" アップデートウィンドウは下に開く
let g:plug_window = 'belowright new' " }}}

" caw.vim{{{
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle) " }}}

" yankround.vim{{{
" YankRing likeなキーバインド
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" キャッシュの保存先
let g:yankround_dir = '~/.cache/yankround' " }}}

" increment-activator{{{
let g:increment_activator_filetype_candidates = {
\ '_' : [
\   [ 'private', 'protected', 'public' ],
\   [ 'right', 'left' ],
\   [ 'up', 'down' ],
\   [ 'top', 'bottom' ],
\   [ 'max', 'min' ],
\   [ 'width', 'height' ]
\ ],
\ 'gitrebase': [
\   [ 'pick', 'reword', 'edit', 'squash', 'fixup', 'exec' ]
\ ]
\ } " }}}

" incsearch.vim{{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)zz
map #  <Plug>(incsearch-nohl-#)zz
map g* <Plug>(incsearch-nohl-g*)zz
map g# <Plug>(incsearch-nohl-g#)zz " }}}

" lexima.vim{{{
" <と>に関するルール
" <>と入力すると<#>とカーソルを真ん中に
" <と入力しただけで>を補完しないのは不等号入力を考えて
call lexima#add_rule({'char': '>', 'at': '<\%#', 'input': '', 'input_after': '>'})
" <#>で>を入力すると<>の外に出る
call lexima#add_rule({'char': '>', 'at': '\%#>',  'leave': '>'})
" <#>で<BS>で<>自体を削除
call lexima#add_rule({'char': '<BS>',  'at': '<\%#>', 'input': '<BS>', 'delete': 1})
" コンマを入力した時に後ろにスペースを付ける
call lexima#add_rule({'char': ',', 'input': ',<Space>'})
" ただし、そのまま改行する場合, の後ろのスペースを削除する
call lexima#add_rule({'char': '<CR>',  'at': ', \%#', 'input': '<BS><CR>'})

" Markdown
" 箇条書きでビュレットの-や*の後ろにスペースを付ける
call lexima#add_rule({'char': '-',  'at': '^\s*\%#$',  'input': '- ', 'filetype': 'markdown'})
call lexima#add_rule({'char': '*',  'at': '^\s*\%#$',  'input': '* ', 'filetype': 'markdown'})
" <BS>で一緒に削除
call lexima#add_rule({'char': '<BS>',  'at': '^\s*- \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
call lexima#add_rule({'char': '<BS>',  'at': '^\s*\* \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
" -に関しては連続する場合はヘッダの区切り行なので細工
call lexima#add_rule({'char': '-',  'at': '^- \%#$',  'input': '<BS>-', 'filetype': 'markdown'})
" *についても強調で使うので細工
call lexima#add_rule({'char': '*',  'at': '^\s*\* \%#$',  'input': '<BS>*', 'filetype': 'markdown'}) " }}}

" vim-easy-align{{{
vmap <Enter> <Plug>(EasyAlign) " }}}

" indentLine{{{
" See: https://github.com/Yggdroot/indentLine/issues/125
let g:indentLine_concealcursor = ''
" helpでは無効にする
let g:indentLine_fileTypeExclude = [ 'help' ] " }}}

" ctrlp.vim{{{
" <C-p>はyankroundに使うので代わりに<C-e>を使う
let g:ctrlp_map = '<C-e>'
" 隠しファイルも表示する
let g:ctrlp_show_hidden = 1
" キーマッピングの微調整
if !exists('g:ctrlp_prompt_mappings')
  let g:ctrlp_prompt_mappings = {}
endif
" CTRL-hを水平分割で開くに割当
let g:ctrlp_prompt_mappings['AcceptSelection("h")'] = [ '<C-h>' ]
" CTRL-k/jで履歴をbackward/forwardに遡る
let g:ctrlp_prompt_mappings['PrtHistory(1)'] = [ '<C-k>' ]
let g:ctrlp_prompt_mappings['PrtHistory(-1)'] = [ '<C-j>' ]
" CTRL-p/nで上/下の候補の選択
let g:ctrlp_prompt_mappings['PrtSelectMove("j")'] = [ '<C-n>' ]
let g:ctrlp_prompt_mappings['PrtSelectMove("k")'] = [ '<C-p>' ]
" 表示リストの各項目の頭の文字を「> 」から変更
let g:ctrlp_line_prefix = ' '
" core typeはファイル検索のみにする
let g:ctrlp_types = [ 'fil' ]
" The prefix key
nnoremap [ctrlp] <Nop>
nmap e [ctrlp]
nnoremap <silent> [ctrlp]e :CtrlP<CR>
" 行
nnoremap <silent> [ctrlp]l :CtrlPLine<CR>
" QuickFix
nnoremap <silent> [ctrlp]q :CtrlPQuickfix<CR>
" アウトライン(ctrlp-funky)
nnoremap <silent> [ctrlp]f :CtrlPFunky<CR> " }}}

" vim-go{{{
let g:go_fmt_command = "goimports"
autocmd vimrc FileType go nnoremap <buffer> <Leader>f :<C-u>GoFmt<CR> " }}}

" rust.vim, vim-racer{{{
autocmd vimrc FileType rust nnoremap <buffer> <Leader>f :<C-u>RustFmt<CR>
let g:racer_experimental_completer = 1
 " }}}

" colorscheme: gruvbox{{{
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

colorscheme gruvbox " }}}

" lightline.vim{{{
" statuslineを常に表示
set laststatus=2

" lightline.vim
if !exists('g:lightline')
  let g:lightline = {}
endif
" colorscheme
let g:lightline.colorscheme = 'gruvbox'
" セパレータの指定
let g:lightline.separator    = { 'left' : '', 'right' : '' }
let g:lightline.subseparator = { 'left' : '', 'right' : '' }
let g:lightline.component_function = {
\ 'mode'     : 'LightLineMode',
\ 'filename' : 'LightLineFilename',
\ 'freezed'  : 'LightLineFreezed',
\ 'modified' : 'LightLineModified',
\ 'newline'  : 'LightLineNewline',
\ 'encoding' : 'LightLineEncoding',
\ 'filetype' : 'LightLineFiletype',
\ }

" CtrlPの時もうまいことやるためにちょっと細工
let g:ctrlp_status_func = {
\ 'main' : 'CtrlPStatuslineMain',
\ 'prog' : 'CtrlPStatuslineProg'
\ }
function! CtrlPStatuslineMain
\                (focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_item = a:item " 今の検索モード(files, mru, lineなど)
  return lightline#statusline(0)
endfunction
function! CtrlPStatuslineProg(str)
  return '%#Number#'. a:str . '%*%< files have been scanned under %#Directory#' . getcwd() . '%*'
endfunction

" Vimの今のモード
function! LightLineMode()
  let fname = expand('%:t')
  return  &ft ==# 'netrw' ? 'Netrw' :
  \ &ft ==# 'gundo' ? 'Gundo' :
  \ fname ==# '__Gundo_Preview__' ? 'Gundo-P' :
  \ fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ?
  \   'CtrlP/'. g:lightline.ctrlp_item :
  \ lightline#mode()
endfunction

" そのファイルは「変更可能」か？
function! LightLineFreezed()
  " 'modifiable'と'readonly'は実はいろいろ違うけど
  " http://tyru.hatenablog.com/entry/20101107/modifiable_and_readonly
  " ここではあえて一緒くたに扱うことにする
  return ( !&modifiable || &readonly ) ? 'X' : ''
endfunction

" modifiableでないときに-を表示しない
function! LightLineModified()
  return &modified ? '+' : ''
endfunction

" OS名ではなくCR/LF/CR+LFで表示
function! LightLineNewline()
  if winwidth(0) <= 70
    return ''
  endif
  let l:table = { 'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
  return l:table[&fileformat]
endfunction

" 文字エンコーディング。全部大文字で
function! LightLineEncoding()
  if winwidth(0) <= 70
    return ''
  endif
  return toupper(&fileencoding !=# '' ? &fileencoding : &encoding)
endfunction

" Capital Caseにして少しかっこよく
function! LightLineFiletype()
  if winwidth(0) <= 70
    return ''
  endif
  return &filetype !=# '' ?
  \ substitute(&filetype , '\<\(\w\)\(\w*\)\>', '\u\1\L\2', 'g')
  \ : 'NONE'
endfunction

function! LightLineFilename()
  let l:fname = expand('%:t')
  if &filetype ==# 'netrw'
    " netrwでは開いているディレクトリを表示
    return substitute(getline(3), '"\s\+', '', 'g')
  elseif l:fname ==# '__Gundo__' || l:fname ==# '__Gundo_Preview__'
    " Gundoでは何も表示しない
    return ''
  elseif l:fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    return getcwd()
  elseif l:fname ==# ''
    return '[No Name]'
  else
    " 幅がある程度広い場合フルパスで表示
    if winwidth(0) <= 100
      return l:fname
    else
      return expand('%:p')
    endif
  endif
endfunction

let g:lightline.active = {
\ 'left' : [[ 'mode' ], [ 'filename', 'freezed', 'modified' ]],
\ 'right' : [[ 'newline', 'encoding', 'filetype' ]]
\ }
let g:lightline.inactive = {
\ 'right' : []
\ }
 " }}}
