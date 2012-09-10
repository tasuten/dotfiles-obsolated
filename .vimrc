" .vimrcのエンコーディング指定
scriptencoding utf-8

" Vim特有の設定とかすると思うのでvi互換をオフに
" 実はこの値はvimrcかgvimrcが見つかった時点でcompatibleがオフになるので
" vimrcなどで書いても余り意味はないらしい
" http://vim-users.jp/2010/10/hack179/
" が、非互換モードであるのが分かるように明示的に書いておく
set nocompatible

" バックアップファイルやスワップファイルをtmp以下に
set directory=~/.vim/tmp/swap
set backupdir=~/.vim/tmp/backup

" アンドゥ履歴をファイルに保存。これもtmp以下に
" なお、この機能はVim7.3から追加されたとか
if has('persistent_undo')
  set undodir=~/.vim/tmp/undo
  set undofile
endif

" Backspaceをちょっと賢く。インデントとかも消せるように
set backspace=indent,eol,start

" 常に大文字小文字を区別して検索（置換時の検索等含む）
" 大文字小文字を区別せず検索したい時は\cをパターン中に含める
" eg.) /aa\c みたく
" 置換だと:%s/hoge/fuga/gi みたくiフラグを入れてもいい
set noignorecase
set nosmartcase

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
set listchars=tab:>\ 
" highlight SpecialKey ctermfg=lightblue guibg=lightblue

" 行番号を濃い灰色で表示
" highlightの色とかは:so $VIMRUNTIME/syntax/colortest.vim 参照
set number
" highlight LineNr ctermfg=darkgray

" 補完候補の色変更
" highlight Pmenu ctermfg=white ctermbg=magenta
" highlight PmenuSel ctermfg=lightgray ctermbg=darkgray

" カーソルがある行をハイライト
set cursorline

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

" ()みたいに打った時カーソルを()の中に
" Cとかだったらinoremap /**/ /**/<Left><Left>とかいいかも
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap () ()<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `` ``<Left>
inoremap <> <><Left>

" カンマ(,)の後に自動的にスペースを入れる
inoremap , ,<Space>

" カーソル移動を物理行でなくレイアウト行で
" 物理行で移動するにはC-pやC-nで
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
" YankRingでも同じように
" http://d.hatena.ne.jp/yano3/20090526/1243350033
let g:yankring_n_keys = 'Y D'

" クリップボードからの貼り付け
inoremap <silent> <C-r>* <C-o>:set paste<CR><C-r>*<C-o>:set nopaste<CR>

" 検索結果のハイライトを<C-h>でトグル
" http://stackoverflow.com/questions/99161/how-do-you-make-vim-unhighlight-what-you-searched-for
nnoremap <silent> <C-h> :set hlsearch!<CR>

" Vim-users.jp - Hack #74: 簡単にvimrcを編集する
" http://vim-users.jp/2009/09/hack74/ より
" .(g)vimrcを編集するためのkey-mapping
nnoremap <silent> <Space>v  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>g  :<C-u>edit $MYGVIMRC<CR>
" .(g)vimrcを反映するためのkey-mapping
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

" <Space>sでスクラッチファイルを開く。:ScratchはKaoriYa同梱
nnoremap <Space>s :Scratch<CR>

" <ESC>と誤爆しやすい<F1>でヘルプが表示されないように
inoremap <F1> <Nop>
nnoremap <F1> <Nop>

" 誤爆しやすいq:等をqq:に割り当て(Vimテクニックバイブル P.124より)
" qqは「qというレジスタにレコーディング」というコマンドと衝突するが
" その時はtimeoutlenだけ待ちましょう
nnoremap qq: <ESC>q:
nnoremap qq/ <ESC>q/
nnoremap qq? <ESC>q?
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" helpをブラウズ時なんかに、CTRL-]から戻るのにCTRL-OやCTRL-Tは少し打ちにくいので、
" CTRL-_に。本当はCTRL-:にしたかったけど、そんなキーコードはASCII的に無い
nnoremap <C-_> <C-o>

" *.mdなファイルのfiletypeををmodula2ではなくmarkdownとする
autocmd BufNewFile,BufRead *.md setfiletype markdown

" Vimバンドルのnetrw.vimをファイラとしても使う
" http://blog.tojiru.net/article/234400966.html 参考
" 簡易な操作説明としては、<CR>で現在のバッファに、tで新しいタブに
" oでsplitしてそのファイルを開く、vでvsplitしてそのファイルを開く
" iで表示スタイルの切り替え
" splitしてnetrwを開くキーバインド。大文字だとプロンプトを出す
nnoremap <Space>n :Sexplore<CR>
nnoremap <Space>N :Sexplore<Space>
" oで下側にsplit、vで右側にvsplitする（デフォルトは逆方向）
" ちなみに<CR>の挙動はg:netrw_browse_splitで変更可能
let g:netrw_alto = 1
let g:netrw_altv = 1
" ブックマークと履歴の保存先
let g:netrw_home = $HOME.'/.vim/'
" デフォルトでツリー表示にする
let g:netrw_liststyle = 3
" netrwの画面ではqqqで閉じる
autocmd FileType netrw nnoremap <buffer> qqq :q<CR>


" ここからプラグイン設定

" NeoBundle
" set nocompatible               " be iMproved
filetype off                   " required!
filetype plugin indent off     " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'endwise.vim'
NeoBundle 'matchit.zip'
NeoBundle 'The-NERD-Commenter'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'mattn/webapi-vim'
" vimprocはvimshellとquickrunの非同期実行に必要
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \ 'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
    \ },
  \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'YankRing.vim'
" Google翻訳APIの有料化により利用不可
" NeoBundle 'mattn/googletranslate-vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'ZenCoding.vim'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'sudo.vim'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'nishigori/vim-sunday'
NeoBundle 'thinca/vim-template'
NeoBundle 'camelcasemotion'
NeoBundle 'thinca/vim-prettyprint'
NeoBundle 't9md/vim-quickhl'
NeoBundle 'capslock.vim'
" 要python
NeoBundle 'sjl/gundo.vim'

" text-object
NeoBundle 'kana/vim-textobj-user'
" 以下i, a以降のキーのみ示す。ちなみにaはオブジェクト全体、iはその"内側"
" 例（削除の例）: da → dida/dada
" 時刻リテラル。da等
NeoBundle 'kana/vim-textobj-datetime'
" コメント。c
NeoBundle 'thinca/vim-textobj-comment'
" 日本語の括弧類。（）はjbかj(かj)、「」はjk、『』はjK、【】はjs
NeoBundle 'kana/vim-textobj-jabraces'

" ref
NeoBundle 'thinca/vim-ref'
NeoBundle 'taka84u9/vim-ref-ri'

" neocomplcache
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'neco-look'

" unite.vimとそのsource類
" https://github.com/Shougo/unite.vim/wiki/unite-plugins とか参考になるかと
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'h1mesuke/unite-outline'
" colorschemeを変更するsource
" -auto-previewと組み合わせると便利かもしれない、とのこと
NeoBundle 'ujihisa/unite-colorscheme'
" GVim限定だがフォントを変更するsource
NeoBundle 'ujihisa/unite-font'
NeoBundle 'mattn/unite-remotefile'
" unite.vimでVim Hacksを閲覧するプラグイン
" webapi-vimとvim-openbufに依存
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'choplin/unite-vim_hacks'
" これ以外にもvim-refにもuniteのsourceが付属。:Unite ref/refeのように使用
" Uniteについては、Unite本体についてくるUnite-findやUnite-grepがすごく便利そう

" filetype類
NeoBundle 'html5.vim'
NeoBundle 'HTML5-Syntax-File'
NeoBundle 'thinca/vim-ft-clojure'

" colorscheme類
NeoBundle 'Wombat'
NeoBundle 'wombat256.vim'
NeoBundle 'nanotech/jellybeans.vim'

" 自作プラグイン
NeoBundle 'tasuten/gcalc.vim'

" リポジトリを持たないプラグイン
let g:local_plugin_base_path = $HOME.'/.vim/local_bundle/'
" neobundleでpathogenと同等の機能を使用する方法 | karakaram-blog
" http://www.karakaram.com/vim/neobundle120421/
" NeoBundle 'plugin1', {'type' : 'nosync', 'base' : '~/.vim/bundle/local'}
" => .vim/bundle/local/plugin1/(plugin|doc|autoload|...)
" rsense.vim
NeoBundle 'rsense.vim', {'type' : 'nosync', 'base' : g:local_plugin_base_path}
" eregex.vim
NeoBundle 'eregex.vim', {'type' : 'nosync', 'base' : g:local_plugin_base_path}
" vim:scheme.vim http://legacy.e.tir.jp/wiliki?vim%3ascheme.vim#H-xl1p5w の
" Gauche用シンタックスファイル
NeoBundle 'gauche-syntax', {'type' : 'nosync', 'base' : g:local_plugin_base_path}
" 今のところ雑多な自作プラグイン等は全部まとめてmypluginに、
" 他の方が書いたちょっとしたスクリプトなんかはscriptsに放り込んでる
NeoBundle 'myplugin', {'type' : 'nosync', 'base' : g:local_plugin_base_path}
NeoBundle 'scripts', {'type' : 'nosync', 'base' : g:local_plugin_base_path}

filetype plugin indent on

" Uniteを用いたNeoBundleのUpdateの非同期実行
command! -nargs=0 NeoBundleUpdateUnite Unite neobundle/update -auto-quit

" NeoBundleここまで


" open-browser.vim
" wはWebから''
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
" markdownではvimprocによる非同期実行が遅いので無効化
let g:quickrun_config.markdown = {
      \ 'runner' : 'system',
      \ 'type' : 'markdown/bluecloth',
      \ 'cmdopt' : '-f',
      \ 'outputter' : 'browser'
      \ }

" NERD_Commenter
" コメントの間にスペースを入れる
let NERDSpaceDelims = 1
" schemeがサポートされてないのでschemeについて
" （commentstringはNERD_Commenterのみに限らないVim標準？の変数？）
autocmd FileType scheme setlocal commentstring=;\ %s

" neocomplcache
" 主に:help neocomplcache-exampleより
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
" \  'vimshell' : $HOME.'/.vimshell_hist',
" の行を少し書き換えた
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell/command-history',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
" 英字のみキャッシュする
let g:neocomplcache_keyword_patterns.default = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
" inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
" imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" ユーザ定義のsnippetsの保存先ディレクトリ
let g:neocomplcache_snippets_dir = $HOME.'/.vim/snippets'

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" ↑この行あたりの挙動がちょっと変なのでコメントアウト
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
" inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
" let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
" set completeopt+=longest
" let g:neocomplcache_enable_auto_select = 1
" let g:neocomplcache_disable_auto_complete = 1
" inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
" inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
" let g:neocomplcache_omni_patterns.ruby = ''
" let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" include補完
if !exists('g:neocomplcache_include_paths')
  let g:neocomplcache_include_paths = {}
endif
let g:neocomplcache_include_paths.c  =  '/usr/include,'.'/usr/local/include'

" rsense
" 補記:neocomplcacheで補完されない時は
" 何度かやってみるかオムニ補完(<C-x><C-o>)でやるといいかも
" if !exists('g:neocomplcache_omni_patterns')
"  let g:neocomplcache_omni_patterns = {}
" endif
" let g:rsenseUseOmniFunc = 1
" if filereadable(expand('/usr/local/bin/rsense'))
  " let g:rsenseHome = expand(substitute(system('brew --prefix rsense'), '\n', '', 'g').'/libexec')
  " let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" endif

" neocomplcacheここまで

" ZenCoding.vim
if !exists('g:user_zen_settings')
  let g:user_zen_settings = {}
endif
let g:user_zen_settings.indentation = '  '
let g:user_zen_settings.lang = 'ja'
" let g:user_zen_complete_tag = 1

" scheme.vim（Gauche向けシンタックスファイル。~/.vim/syntax/scheme.vim）
" http://legacy.e.tir.jp/wiliki?vim%3Ascheme.vim
autocmd FileType scheme :let is_gauche=1

" ref.vim
" webdictソースについて
if !exists('g:ref_source_webdict_sites')
 let g:ref_source_webdict_sites = {}
endif
" Wikipedia（日本語版）
let g:ref_source_webdict_sites.wikipedia = {
      \  'url' : 'http://ja.wikipedia.org/wiki/%s',
      \ 'keyword_encoding' : 'utf-8',
      \ 'cache' : 1
      \ }
" Wiktionary
" 15行目（あたり）に適当にフォーカス
let g:ref_source_webdict_sites.wiktionary = {
      \  'url' : 'http://ja.wiktionary.org/wiki/%s',
      \ 'keyword_encoding' : 'utf-8',
      \ 'cache' : 1,
      \ 'line' : 15
      \ }
" Infoseekマルチ辞書
" http://www.karakaram.com/vim/ref-webdict/ 参考
" 最初の数行を削除している
" 和英
let g:ref_source_webdict_sites.je = {
      \  'url' : 'http://dictionary.infoseek.ne.jp/jeword/%s',
      \ 'keyword_encoding' : 'utf-8',
      \ }
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
" 英和
let g:ref_source_webdict_sites.ej = {
      \  'url' : 'http://dictionary.infoseek.ne.jp/ejword/%s',
      \ 'keyword_encoding' : 'utf-8',
      \ }
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction

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
" ref.vim/webdict
nnoremap [doc]wp :<C-u>Ref<Space>webdict<Space>wikipedia<Space>
nnoremap [doc]wt :<C-u>Ref<Space>webdict<Space>wiktionary<Space>
nnoremap [doc]je :<C-u>Ref<Space>webdict<Space>je<Space>
nnoremap [doc]ej :<C-u>Ref<Space>webdict<Space>ej<Space>

" unite.vim
" http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin を参考にした

" The prefix key.
nnoremap [unite] <Nop>
nmap f [unite]

" 入力モードで開始する
let g:unite_enable_start_insert=1

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
" source一覧
nnoremap <silent> [unite]s :<C-u>Unite source<CR>
" 全部乗せ
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" Unite grep
nnoremap [unite]g :<C-u>Unite grep -buffer-name=grep -no-quit -auto-preview<CR>

" Unite outline
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
" Unite colorscheme
nnoremap <silent> [unite]cs :<C-u>Unite colorscheme -auto-preview<CR>

" file選択時でのデフォルトアクション（<CR>の時とかの挙動）をopenではなくsplitに
call unite#custom_default_action('file', 'split')

" そのウィンドウに直に開く(open。:eな感じ？)
au FileType unite nnoremap <silent> <buffer> <expr> <C-e> unite#do_action('open')
au FileType unite inoremap <silent> <buffer> <expr> <C-e> unite#do_action('open')
" ウィンドウを分割して開く
" au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
" au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
" au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" unite.vimここまで

" VimShell
nnoremap <silent> <Leader>vs :<C-u>VimShellPop -toggle<CR>

" YankRing.vim
" 履歴ファイルは
" g:yankring_history_dir.g:yankring_history_file.'_v2.txt'
" という感じのファイルに保存される。この設定なら~/.vim/.yankring_history_v2.txt
let g:yankring_history_dir = $HOME.'/.vim/'
let g:yankring_history_file = '.yankring_history'

" w3m.vim
let g:w3m#external_browser = 'open -a Firefox'
let g:w3m#homepage = 'http://www.google.co.jp/'

" current-func-info.vim
" サポート外のファイルタイプの場合何も表示しないようにちょっとした関数を
" ちなみにC, Perl, Ruby, Python, PHP, VimScをサポートしてるとか
function! Cfi_warpper()
  if cfi#supported_filetype(&filetype)
    return cfi#format("[%s()]", "No")
  else
    return ""
  endif
endfunction

" template.vim
" execute内は<>で囲まれたテキストオブジェクト全体(a>)を
" 削除レジスタ("_)へ削除(d)の意味
" つまり<Cursor>を消去している
" 最終的にカーソルは<Cursor>の有った場所の一つ前にある
autocmd User plugin-template-loaded
      \ if search('<Cursor>')
      \ | execute 'normal! "_da>'
      \ | endif

" camelcasemotion
" :h camelcasemotion-configuration より
map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
" テキストオブジェクト
omap iw <Plug>CamelCaseMotion_iw
xmap iw <Plug>CamelCaseMotion_iw
omap ib <Plug>CamelCaseMotion_ib
xmap ib <Plug>CamelCaseMotion_ib
omap ie <Plug>CamelCaseMotion_ie
xmap ie <Plug>CamelCaseMotion_ie


"eregex.vim
" 置換は:<range>s -> :<range>Sで
" eregex.vim版はprefixに,を付ける
nnoremap [eregex] <nop>
nmap , [eregex]
nnoremap [eregex]/ :<C-u>M/
nnoremap [eregex]? :<C-u>?
nnoremap [eregex]* :<C-u>execute 'M/\<' . expand('<cword>') . '\>' <CR>
nnoremap [eregex]g* :<C-u>execute 'M/' . expand('<cword>') <CR>
" Vimデフォルトの検索をeregex.vimで置き換える場合こっち
" これをするとincsearchなんかは使えないので注意
" nnoremap / :<C-u>M/
" nnoremap ? :<C-u>?
" nnoremap * :<C-u>execute 'M/\<' . expand('<cword>') . '\>' <CR>
" nnoremap g* :<C-u>execute 'M/' . expand('<cword>') <CR>
" eregex.vimとは関係ないけどよく似た設定なのでこれもここで
" MacVim-KaoriYa等のKaoriYa版パッチに含まれるmigemo検索が
" デフォルトではg/なのが思い出せないのでm/にも
" 元のmは一応mmに
nnoremap mm m
nnoremap m/ g/

" sunday.vim
let g:sunday_pairs = [
      \   ['right', 'left'],
      \   ['up', 'down'],
      \   ['top', 'bottom'],
      \   ['max', 'min'],
      \   ['width', 'height']
      \ ]

" quickhl.vim
" カーソル下の単語のハイライトをトグル
nmap <Leader>m <Plug>(quickhl-toggle)
xmap <Leader>m <Plug>(quickhl-toggle)
" 全てのハイライトをクリア
nmap <Leader>M <Plug>(quickhl-reset)
xmap <Leader>M <Plug>(quickhl-reset)
" nmap <Leader>j <Plug>(quickhl-match)

" capslock.vim
imap <C-l> <Plug>CapsLockToggle

" gundo.vim
nnoremap U :<C-u>GundoToggle<CR>

" プラグイン設定ここまで


" colorscheme設定

" jellybeans
" 背景色を濃い灰色ではなく黒にする
let g:jellybeans_background_color_256 = 0
let g:jellybeans_background_color = "000000"
" 1.[Tab]なんかの色(SpecialKey)も背景黒、文字はlightblueで
" 2.CursorLineの行の行番号は、CursorLineと同じ感じに
" 3.対応する括弧の色を？山吹色背景黒文字に変更
" 不思議な事にCUIのVimでも何故かgui*の方が適用されてる
let g:jellybeans_overrides = {
      \    'SpecialKey' : {
      \              'guifg': 'add8e6', 'guibg': '000000',
      \              'ctermfg': 'lighblue', 'ctermbg': 'black',
      \              'attr': ''} ,
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
autocmd ColorScheme * call s:my_highlights()
function! s:my_highlights()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
  highlight WhitespaceEOL ctermbg=red guibg=red
  let w:m1 = matchadd('ZenkakuSpace', '　')
  let w:m2 = matchadd('WhitespaceEOL', '\s\+$')
endfunction

" colorschemeの適用
colorscheme jellybeans

" colorschemeを弄るときに便利なコマンドを設定
" カラーパレット
command! -nargs=0 ColorTest runtime syntax/colortest.vim
" 現在のハイライト一覧
command! -nargs=0 HiTest runtime syntax/hitest.vim


" statusline
" statuslineを常に表示
set laststatus=2
"大体こんな感じで表示
" hoge.c [+][utf-8:LF][c]               [main()]  0,0-1    全て
" help.jax [ヘルプ][-][RO][utf-8:LF][help]        1,1      先頭
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline='%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%=%{Cfi_warpper()}  %-14.(%l,%c%V%) %P'



let g:hatena_user = 'tasuten'

