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

" <C-p><C-n>の補完でincludeファイル(requireとか#includeしたファイル)からも
" 補完されるのが邪魔だったのでそうしないように
" デフォルトは.,w,b,u,t,i
set complete=.,w,b,u,t

" コマンドライン補完。最長共通部分を補完しつつ候補をstatuslineに表示した後、
" 候補を順に回る
set wildmenu
set wildmode=longest:full,full

" 最後の行を出来る限り表示する（@のように略さない）
set display=lastline

" タブを可視化
set list
set listchars=tab:»\ ,
" highlight SpecialKey ctermfg=lightblue guibg=lightblue

" 行番号を濃い灰色で表示
set number
" highlight LineNr ctermfg=darkgray

" 補完候補の色変更
" highlight Pmenu ctermfg=white ctermbg=magenta
" highlight PmenuSel ctermfg=lightgray ctermbg=darkgray

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

" 誤爆しやすいq:等をqq:等に割り当て(Vimテクニックバイブル P.124より)
nnoremap qq: <ESC>q:
nnoremap qq/ <ESC>q/
nnoremap qq? <ESC>q?
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" 同じく誤爆しやすいqq(レジスタqにレコーディング)はいっそ無効化
nnoremap qq <Nop>

" helpをブラウズ時なんかに、CTRL-]から戻るのにCTRL-OやCTRL-Tは少し打ちにくいので、
" CTRL-_に。本当はCTRL-:にしたかったけど、そんなキーコードはASCII的に無い
nnoremap <C-_> <C-o>

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
" *.pdeなファイルをArduinoではなくProcessingとみなす
autocmd vimrc BufNewFile,BufRead *.pde setfiletype processing

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

" NeoBundle
" set nocompatible               " be iMproved
filetype off                   " required!
filetype plugin indent off     " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/caw.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/webapi-vim'
" vimprocはquickrunの非同期実行に必要
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\ 'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
\ 'cygwin' : 'make -f make_cygwin.mak',
\ 'mac' : 'make -f make_mac.mak',
\ 'unix' : 'make -f make_unix.mak',
\ },
\ }
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'nishigori/increment-activator'
NeoBundle 'thinca/vim-template'
NeoBundle 'thinca/vim-prettyprint'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'junegunn/vim-easy-align'
NeoBundleLazy 'mattn/lisper-vim'
" 要Python
NeoBundle 'sjl/gundo.vim'

" text-object
NeoBundle 'kana/vim-textobj-user'
" コメント。c
NeoBundle 'thinca/vim-textobj-comment'
" URL。u
NeoBundle 'mattn/vim-textobj-url'
" surround.vim。囲ってる文字を消したり(ds")変えたり(cs"')、
" 新たに囲んだり(ys<範囲><囲むの>, eg.)yss})
NeoBundle 'tpope/vim-surround'

" ref
NeoBundle 'thinca/vim-ref'

" neocomplete
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'ujihisa/neco-look'

" ctrlp.vim
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky'
NeoBundle 'endel/ctrlp-filetype.vim'

" filetype類
NeoBundle 'thinca/vim-ft-clojure'
NeoBundle 'javacomplete', {
\ 'build' : {
\ 'mac' : 'javac -J-Dfile.encoding=UTF-8 autoload/Reflection.java',
\ 'unix' : 'javac autoload/Reflection.java',
\ },
\ }
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'https://bitbucket.org/teramako/jscomplete-vim.git'
NeoBundle 'sophacles/vim-processing'
" vim-ft-clojureの方にも虹色ハイライトあるけど読み込み順的にこっちが有効か
NeoBundle 'spinningarrow/vim-niji'

" colorscheme
NeoBundle 'nanotech/jellybeans.vim'
" statusline
NeoBundle 'itchyny/lightline.vim'

" 自作プラグイン
NeoBundle 'tasuten/gcalc.vim'
NeoBundle 'tasuten/motor.vim'

" リポジトリを持たないプラグイン
" 自作プラグインを neobundle.vim で管理する - C++でゲームプログラミング
" http://d.hatena.ne.jp/osyo-manga/20131022/1382426403
let g:local_plugin_base_path = $HOME.'/.vim/local_bundle/'
command! -nargs=1 NeoBundleLocalPlugin
\   NeoBundle <args>, {
\       'base' : g:local_plugin_base_path,
\       'type' : 'nosync',
\   }
command! -nargs=1 NeoBundleLocalPluginLazy
\   NeoBundleLazy <args>, {
\       'base' : g:local_plugin_base_path,
\       'type' : 'nosync',
\   }

call neobundle#end()

" matchitはVimバンドルのモノを使う
source $VIMRUNTIME/macros/matchit.vim

filetype plugin indent on

" NeoBundleここまで


" open-browser.vim
" wはWebから
nmap <Leader>w <Plug>(openbrowser-open)
vmap <Leader>w <Plug>(openbrowser-open)

" quickrun
if !exists('g:quickrun_config')
  let g:quickrun_config= {}
endif
" vimprocを用いて非同期に実行する
let g:quickrun_config._ = {'runner' : 'vimproc'}
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
" Processing
" http://kazuph.hateblo.jp/entry/2013/03/20/211336
let g:quickrun_config.processing = {
\ 'command' : 'processing-java',
\ 'exec': '%c --sketch=$PWD/ --output=$PWD/quickrun --run --force'
\ }

" caw.vim
" <Leader>cでその行のコメントを切り替え
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

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
\ 'scheme' : $HOME.'/.gosh_completions'
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

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.java = '\%(\.\)\h\w*'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'


" clang_completeの補完をneocompleteで
" http://d.hatena.ne.jp/osyo-manga/20120911/1347354707 より
" neocomplete 側の設定
let g:neocomplete#force_overwrite_completefunc=1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'
" clang_complete 側の設定
" clang_complete の自動呼び出しは切っておく
let g:clang_complete_auto = 0
" プレビューウィンドウを自動的に閉じる
let g:clang_close_preview = 1
" libclangを用いる
let g:clang_use_library = 1
let g:clang_library_path = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/' " f**kin' path
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

" emmet-vim
if !exists('g:user_emmet_settings')
  let g:user_emmet_settings = {}
endif
let g:user_emmet_settings.indentation = '  '
let g:user_emmet_settings.lang = 'ja'
" let g:user_emmet_complete_tag = 1

" ref.vim
" ドキュメントを引くキーバインドのプレフィックスを_で統一
" ちなみに元の機能は__で使えるようにしておいた
nnoremap __ _
nnoremap [doc] <Nop>
nmap _ [doc]
" _hでVimのhelpを引く
nnoremap [doc]h :<C-u>h<Space>
" ref.vim
nnoremap [doc]r :<C-u>Ref<Space>
nnoremap [doc]m :<C-u>Ref<Space>man<Space>
nnoremap [doc]rr :<C-u>Ref<Space>refe<Space>
nnoremap [doc]er :<C-u>Ref<Space>erlang<Space>

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
\   ['private', 'protected', 'public'],
\   ['right', 'left'],
\   ['up', 'down'],
\   ['top', 'bottom'],
\   ['max', 'min'],
\   ['width', 'height']
\ ],
\ 'gitrebase': [
\   ['pick', 'reword', 'edit', 'squash', 'fixup', 'exec']
\ ]
\ }

" quickhl.vim
" カーソル下の単語のハイライトをトグル
nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
" 全てのハイライトをクリア
nmap <Leader>M <Plug>(quickhl-manual-reset)
xmap <Leader>M <Plug>(quickhl-manual-reset)

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

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" ctrlp.vim
" <C-p>はyankroundに使うので代わりに<C-e>を使う
let g:ctrlp_map = '<C-e>'
" 隠しファイルも表示する
let g:ctrlp_show_hidden = 1
" The prefix key
nnoremap [ctrlp] <Nop>
nmap e [ctrlp]
" 行
nnoremap <silent> [ctrlp]l :CtrlPLine<CR>
" アウトライン(ctrlp-funky)
nnoremap <silent> [ctrlp]f :CtrlPFunky<CR>
" ファイルタイプ
nnoremap <silent> [ctrlp]t :CtrlPFiletype<CR>


" gundo.vim
nnoremap U :<C-u>GundoToggle<CR>
autocmd vimrc FileType gundo nnoremap <buffer> :q :<C-u>GundoHide<CR>
autocmd vimrc BufNewFile,BufRead __Gundo_Preview__ nnoremap <buffer> :q :<C-u>GundoHide<CR>

" jscomplete-vim
" DOM APIも補完対象に
let g:jscomplete_use = ['dom']

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

" jellybeans
" 背景色を濃い灰色ではなく黒にする
let g:jellybeans_background_color_256 = 0
let g:jellybeans_background_color = '000000'
" 1.[Tab]なんかの色(SpecialKey)も背景黒、文字はgrayで
" 2.CursorLineの行の行番号は、CursorLineと同じ感じに
" 3.対応する括弧の色を？山吹色背景黒文字に変更
" 不思議な事にCUIのVimでも何故かgui*の方が適用されてる
let g:jellybeans_overrides = {
\    'SpecialKey' : {
\              'guifg': '707070', 'guibg': '000000',
\              'ctermfg': 'gray', 'ctermbg': 'black'} ,
\   'CursorLineNr' : {
\               'guifg' : '707070', 'guibg' : '222222',
\               'ctermfg' : 'gray', 'ctermbg' : 'darkgray'},
\   'MatchParen' : {
\               'guifg' : '222222', 'guibg' : 'fad07a',
\               'ctermfg' : 'darkgray', 'ctermbg' : 'yellow'}
\ }

" ユーザ定義のハイライト
" 1.全角スペースを視覚化
" 全角スペースをライトブルーのアンダーラインで表す
" 2.行末の空白文字をハイライト
" 参考:
" http://d.hatena.ne.jp/piropiropiroshki/20100321/1269119181
" http://mugijiru.seesaa.net/article/203066121.html
" http://vim-users.jp/2009/07/hack40/
autocmd vimrc ColorScheme * call s:my_highlights()
function! s:my_highlights()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
  highlight WhitespaceEOL ctermbg=red guibg=red
  let w:m1 = matchadd('ZenkakuSpace', '　')
  let w:m2 = matchadd('WhitespaceEOL', '\s\+$')
endfunction

" colorschemeの適用
colorscheme jellybeans

" statusline
" statuslineを常に表示
set laststatus=2

" lightline.vim
if !exists('g:lightline')
  let g:lightline = {}
endif
" colorscheme
let g:lightline.colorscheme = 'jellybeans'
" セパレータの指定
let g:lightline.separator    = { 'left' : '', 'right' : '' }
let g:lightline.subseparator = { 'left' : '', 'right' : '' }
" fileformat（改行コード）の表示だけ気に入らなかったので変更
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
let g:lightline.component = {
\   'fileformat' : '%{ff_table[&fileformat]}',
\ }

" Netrw、Gundoの時modeやfilenameをちょっと細工する
let g:lightline.component_function = {
\ 'mode'     : 'MyMode',
\ 'filename' : 'MyFilename',
\ }

function! MyMode()
  let fname = expand('%:t')
  return  &ft ==# 'netrw' ? 'Netrw' :
  \ &ft ==# 'gundo' ? 'Gundo' :
  \ fname ==# '__Gundo_Preview__' ? 'Gundo-P' :
  \ lightline#mode()
endfunction

function! MyFilename()
  let fname = expand('%:t')
  " netrwでは開いているディレクトリを表示
  return &ft ==# 'netrw' ? substitute(getline(3), '"\s\+', '', 'g') :
  \ (fname ==# '__Gundo__' || fname ==# '__Gundo_Preview__') ? '' :
  \ '' !=# fname ? fname : '[No Name]'
endfunction

" readonlyがfilenameより左に表示されるのが気になったので
let g:lightline.active = {
\ 'left' : [['mode', 'paste'], ['filename', 'modified', 'readonly']]
\ }


let g:hatena_user = 'tasuten'

