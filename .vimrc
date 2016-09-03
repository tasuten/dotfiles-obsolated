" .vimrcのエンコーディング指定
scriptencoding utf-8

" autocmd vimrcはgroupに属させたほうが良い
" http://rbtnn.hateblo.jp/entry/2014/11/30/174749
augroup vimrc
  autocmd!
augroup END

" バックアップファイルやスワップファイルをtmp以下に
set directory=~/.vim/tmp/swap
set backupdir=~/.vim/tmp/backup

" アンドゥ履歴をファイルに保存。これもtmp以下に
set undodir=~/.vim/tmp/undo
set undofile

" Backspaceをちょっと賢く。インデントとかも消せるように
set backspace=indent,eol,start

" 常に大文字小文字を区別して検索（置換時の検索等含む）
" 大文字小文字を区別せず検索したい時は\cをパターン中に含める
" eg.) /aa\c みたく
" 置換だと:%s/hoge/fuga/gi みたくiフラグを入れてもいい
set noignorecase
set nosmartcase

" インデントは基本スペースを使う
set expandtab

" スマートインデント
set autoindent
set smartindent

" インデント幅は基本スペース2個
" 明示的に指定する時はftplugin/[filetype].vimで
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

" 行番号を濃い灰色で表示
set number

" カーソルがある行をハイライト
set cursorline

" showcmdは個人的には画面に頻繁にちらつくのが気に入らなかったので
set noshowcmd

" statuslineはプラグイン設定の後で

" インデントに関する設定も反映させるためにindentもonに
filetype on
filetype plugin on
filetype indent on

" ウィンドウ分割で上や左にではなく右や下に開くように
set splitright
set splitbelow

" >や<をshiftwidthの倍数倍に丸めるようにする
set shiftround

" USキーボードでは:がShift-;で押しにくいので;と入れ替え
noremap ; :
noremap : ;

" カーソル移動を物理行でなくレイアウト行で
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj

" Hで行頭、Lで行末へ
" ノーマルモード、ビジュアルモード、演算待モードで有効
map H 0
map L $

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

" クリップボードからの貼り付け
inoremap <silent> <C-r>* <C-o>:set paste<CR><C-r>*<C-o>:set nopaste<CR>
inoremap <silent> <C-r>+ <C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>

" <C-hjkl>でウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" tをprefixにしてタブページの操作
" tmuxに一応合わせてる
" The prefix key.
nnoremap [tab] <Nop>
nmap t [tab]
" n番タブにジャンプ
for s:n in range(1, 9)
  execute 'nnoremap <silent> [tab]'.s:n  ':<C-u>tabnext '.s:n.'<CR>'
endfor
" 一番右にタブを開く
nnoremap <silent> [tab]c :<C-u>tablast <bar> tabnew<CR>
" 次のタブ
nnoremap <silent> [tab]t :<C-u>tabnext<CR>
nnoremap <silent> [tab]n :<C-u>tabnext<CR>
" 前のタブ
nnoremap <silent> [tab]p :<C-u>tabprevious<CR>
" タブを閉じる
nnoremap <silent> [tab]q :<C-u>tabclose<CR>
nnoremap <silent> [tab]k :<C-u>tabclose<CR>
" ファイルを指定して新しいタブを開く
nnoremap [tab]N :tabnew<Space>

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

" *.mdなファイルのfiletypeををmodula2ではなくmarkdownとする
" 2014年10月頃に*.mdファイルもmarkdown扱いされるようになったけど
" https://github.com/vim/vim/commit/7d76c804af900ba6dcc4b1e45373ccab3418c6b2
" まだ過渡期な気がするのでもうしばらく書いておく
autocmd vimrc BufNewFile,BufRead *.md setfiletype markdown

" TeXは全てLaTeXと見做す
let g:tex_flavor = 'latex'

" Vimファイルでの行継続の\の位置を指定
let g:vim_indent_cont = 0

" gitのコミットメッセージ編集時にDでdiffをプレビュー
autocmd vimrc FileType gitcommit nnoremap <buffer> D :DiffGitCached<CR>
autocmd vimrc FileType git nnoremap <buffer> D :q<CR>

" Vimで shebang 付ファイルを保存時に実行権限を自動で付加する
" http://d.hatena.ne.jp/spiritloose/20060519/1147970872 より
autocmd vimrc BufWritePost * :call AddExecmod()
function AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) ==# '#!'
    call system('chmod +x '. expand('%'))
  endif
endfunction


" ここからプラグイン設定

" vim-plug
" vim-plugそのもののアップデートはPlugUpgradeで

call plug#begin('~/.vim/plugged')

Plug 'thinca/vim-quickrun'
Plug 'tyru/caw.vim'
Plug 'tyru/open-browser.vim'
Plug 'mattn/webapi-vim'
Plug 'Shougo/vimproc', { 'do' : 'make' }
Plug 'LeafCage/yankround.vim'
Plug 'nishigori/increment-activator'
Plug 'thinca/vim-template'
Plug 'thinca/vim-prettyprint'
Plug 'haya14busa/incsearch.vim'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
" 要Python
Plug 'sjl/gundo.vim'

" text-object
Plug 'kana/vim-textobj-user'
" URL。u
Plug 'mattn/vim-textobj-url'
" surround.vim。囲ってる文字を消したり(ds")変えたり(cs"')、
" 新たに囲んだり(ys<範囲><囲むの>, eg.)yss})
Plug 'tpope/vim-surround'

" ref
Plug 'thinca/vim-ref'

" neocomplete
Plug 'Shougo/neocomplete'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'ujihisa/neco-look'

" ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'

" filetype類
Plug 'javacomplete', {
\ 'do' : 'javac -J-Dfile.encoding=UTF-8 autoload/Reflection.java',
\ 'for' : 'java'
\ }
Plug 'https://bitbucket.org/teramako/jscomplete-vim.git',
\ { 'for' : 'javascript' }
Plug 'elixir-lang/vim-elixir', { 'for' : 'elixir' }
Plug 'liquidz/vivi.vim', { 'for' : 'elixir' }
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'spinningarrow/vim-niji'

" colorscheme
Plug 'tasuten/Fugaku'
" statusline
Plug 'itchyny/lightline.vim'

" 自作プラグイン
Plug 'tasuten/gcalc.vim'
Plug 'tasuten/motor.vim'

call plug#end()

" vim-plugここまで

" 使わない標準プラグインを無効化
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1

" vim-plug
" アップデートウィンドウは下に開く
let g:plug_window = 'belowright new'

" open-browser.vim
" wはWebから
nmap <Leader>w <Plug>(openbrowser-open)
vmap <Leader>w <Plug>(openbrowser-open)

" quickrun
if !exists('g:quickrun_config')
  let g:quickrun_config= {}
endif
" vimprocを用いて非同期に実行する
let g:quickrun_config._ = { 'runner' : 'vimproc' }
" HTMLの場合openで開くようにする
let g:quickrun_config.html = { 'command' : 'open', 'exec' : ['%c %s'] }
" Javaの文字化け対策
let g:quickrun_config.java = { 'exec': ['javac -J-Dfile.encoding=UTF-8 %o %s', '%c -Dfile.encoding=UTF-8 %s:t:r %a', ':call delete("%S:t:r.class")'] }
" Markdown
" markdownではvimprocによる非同期実行が遅いのでその設定を無効化
let g:quickrun_config.markdown = {
\ 'runner' : 'system',
\ 'type' : 'markdown/redcarpet',
\ 'outputter' : 'browser'
\ }

" caw.vim
" <Leader>cでその行のコメントを切り替え
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" neocomplete
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_syntax_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
\ 'default' : '',
\ 'scheme' : $RLWRAP_HOME.'/gosh_completions'
\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
" 英字のみキャッシュする
let g:neocomplete#keyword_patterns.default = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()

" Enable omni completion.
autocmd vimrc FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd vimrc FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd vimrc FileType javascript setlocal omnifunc=jscomplete#CompleteJS
autocmd vimrc FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd vimrc FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd vimrc FileType java setlocal omnifunc=javacomplete#Complete
autocmd vimrc FileType elixir setlocal omnifunc=vivi#complete#omni

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.java = '\%(\.\)\h\w*'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.elixir = '[^.[:digit:] *\t]\.'

" neocompleteここまで


" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" ユーザ定義のsnippetsの保存先ディレクトリ
let g:neosnippet#snippets_directory = $HOME.'/.vim/snippets'
" Runtime snippetsを無効化したいfiletype。1で無効化
let g:neosnippet#disable_runtime_snippets = {
\   'java' : 1,
\ }

" ref.vim
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

" yankround.vim
" YankRing likeなキーバインド
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" キャッシュの保存先
let g:yankround_dir = '~/.cache/yankround'

" template.vim
" execute内は<>で囲まれたテキストオブジェクト全体(a>)を
" 削除レジスタ("_)へ削除(d)の意味
" つまり<Cursor>を消去している
" 最終的にカーソルは<Cursor>の有った場所の一つ前にある
autocmd vimrc User plugin-template-loaded
\ if search('<Cursor>')
\ | execute 'normal! "_da>'
\ | endif

" MacVim-KaoriYa等のKaoriYa版パッチに含まれるmigemo検索が
" デフォルトではg/なのが思い出せないのでm/にも
" 元のmは一応mmに
nnoremap mm m
nnoremap m/ g/

" increment-activator
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
\ }

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)zz
map N  <Plug>(incsearch-nohl-N)zz
map *  <Plug>(incsearch-nohl-*)zz
map #  <Plug>(incsearch-nohl-#)zz
map g* <Plug>(incsearch-nohl-g*)zz
map g# <Plug>(incsearch-nohl-g#)zz

" lexima.vim
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
call lexima#add_rule({'char': '*',  'at': '^\s*\* \%#$',  'input': '<BS>*', 'filetype': 'markdown'})


" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" indentLine
" See: https://github.com/Yggdroot/indentLine/issues/125
let g:indentLine_concealcursor = ''
" helpでは無効にする
let g:indentLine_fileTypeExclude = [ 'help' ]

" ctrlp.vim
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
" CTRL-n/pで上/下の候補の選択
let g:ctrlp_prompt_mappings['PrtSelectMove("j")'] = [ '<C-n>' ]
let g:ctrlp_prompt_mappings['PrtSelectMove("k")'] = [ '<C-p>' ]
" 表示リストの各項目の頭の文字を「> 」から変更
let g:ctrlp_line_prefix = ' '
" core typeはファイル検索のみにする
let g:ctrlp_types = [ 'fil' ]
" The prefix key
nnoremap [ctrlp] <Nop>
nmap e [ctrlp]
" 行
nnoremap <silent> [ctrlp]l :CtrlPLine<CR>
" QuickFix
nnoremap <silent> [ctrlp]q :CtrlPQuickfix<CR>
" アウトライン(ctrlp-funky)
nnoremap <silent> [ctrlp]f :CtrlPFunky<CR>


" gundo.vim
nnoremap U :<C-u>GundoToggle<CR>
autocmd vimrc FileType gundo nnoremap <buffer> :q :<C-u>GundoHide<CR>
autocmd vimrc BufNewFile,BufRead __Gundo_Preview__ nnoremap <buffer> :q :<C-u>GundoHide<CR>

" jscomplete-vim
" DOM APIも補完対象に
let g:jscomplete_use = [ 'dom' ]

" vivi.vim
" iexを立ち上げとく。refやomni補完を使うときに便利
let g:vivi_enable_auto_warm_up_iex = 1
" omni補完
let g:vivi_enable_omni_completion = 1

" motor.vim
let g:motor#default_word_pattern = [
\ '\l+',
\ '\u\l+',
\ '\u+',
\ '\d+',
\ '%(\s+|\_^)\zs[!-/:-?\[-`{-~]+\ze%(\s+|$)',
\ '[ぁ-んー〜]+',
\ '[ァ-ンヴヵヶー〜]+',
\ '[一-龠々〇]+'
\]

map  w  <Plug>(motor-w)
map  b  <Plug>(motor-b)
" map  e  <Plug>(motor-e)
map  ge <Plug>(motor-ge)
omap iw <Plug>(motor-textobj-w)
xmap iw <Plug>(motor-textobj-w)

" プラグイン設定ここまで


" colorscheme設定

" ユーザ定義のハイライトグループ
" ZenkakuSpace: 全角スペース
" WhitespaceEOL: 行末のスペース
autocmd vimrc ColorScheme * call s:my_highlights()
function! s:my_highlights()
  let w:m1 = matchadd('ZenkakuSpace', '　')
  let w:m2 = matchadd('WhitespaceEOL', '\s\+$')
endfunction

if !exists('g:fugaku_customize')
  let g:fugaku_customize = {}
endif
let g:fugaku_customize.ZenkakuSpace = {
\ 'ctermfg' : 247, 'cterm' : 'underline',
\ 'guifg' : '#3f493e', 'gui' : 'underline'
\ }
let g:fugaku_customize.WhitespaceEOL = { 'ctermbg' : 131, 'guifg' : '#ab4645' }

" ターミナルエミュレータの背景色に合わせる
let g:fugaku_use_terminal_background_color = 1

" colorschemeの適用
colorscheme Fugaku

" statusline
" statuslineを常に表示
set laststatus=2

" lightline.vim
if !exists('g:lightline')
  let g:lightline = {}
endif
" colorscheme
let g:lightline.colorscheme = 'Fugaku'
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

