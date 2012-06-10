" Tabのことなどファイルタイプごとの設定は~/.vim/ftplugin/filetype.vimにある
" もしかすると書かなくてもそのとおりに動くようなものもあると思うけど念のため

" .vimrcのエンコーディング指定
scriptencoding utf-8

" Vim特有の設定とかすると思うのでvi互換をオフに
" 実はこの値はvimrcかgvimrcが見つかった時点でcompatibleがオフになるので
" vimrcなどで書いても余り意味はないらしい
" http://vim-users.jp/2010/10/hack179/
" が、非互換モードであるのが分かるように明示的に書いておく
set nocompatible

" バックアップファイルやスワップファイルを一箇所に
set directory=~/.vim/tmp
set backupdir=~/.vim/tmp

" Backspaceをちょっと賢く。インデントとかも消せるように
set backspace=indent,eol,start

" <C-p><C-n>の補完でincludeファイル(requireとか#includeしたファイル)からも
" 補完されるのが邪魔だったのでそうしないように
" デフォルトは.,w,b,u,t,i
set complete=.,w,b,u,t

" タブを可視化
set list
set listchars=tab:>-
highlight SpecialKey ctermfg=lightblue guibg=lightblue

" 行番号を濃い灰色で表示
" highlightの色とかは:so $VIMRUNTIME/syntax/colortest.vim 参照
set number
highlight LineNr ctermfg=darkgray

" 補完候補の色変更
highlight Pmenu ctermfg=white ctermbg=magenta
highlight PmenuSel ctermfg=lightgray ctermbg=darkgray

" ※（colorschemeにかかわらず適用させたい）ハイライト設定はもっと後ろの方参照


" statuslineはプラグイン設定の後で

" インデントに関する設定も反映させるためにindentもonに
filetype on
filetype plugin on
filetype indent on

" ウィンドウ分割で上や左にではなく右や下に開くように
set splitright
set splitbelow

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

" x, Xで削除した文字はレジスタに突っ込ませないようにする
nnoremap x "_x
nnoremap X "_X
" YankRingでも同じように
" http://d.hatena.ne.jp/yano3/20090526/1243350033
let g:yankring_n_keys = 'Y D'

" 検索結果のハイライトを<C-h>でトグル
" http://stackoverflow.com/questions/99161/how-do-you-make-vim-unhighlight-what-you-searched-for
nnoremap <silent> <C-h> :set hlsearch!<CR>

" Vim-users.jp - Hack #74: 簡単にvimrcを編集する
" http://vim-users.jp/2009/09/hack74/ より
" .(g)vimrcを編集するためのkey-mapping
nnoremap <silent> <Space>ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>eg  :<C-u>edit $MYGVIMRC<CR>
" .(g)vimrcを反映するためのkey-mapping
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif <CR>
nnoremap <silent> <Space>rg :<C-u>source $MYGVIMRC<CR>

" ファイル新規作成時にテンプレートファイルを読み込む
" どうせならそれ系のプラグインとか入れてカーソルを良い感じの位置に…とか
autocmd BufNewFile *.scm 0r ~/.vim/template/template.scm

" *.mdなファイルのfiletypeををmodula2ではなくmarkdownとする
autocmd BufNewFile,BufRead *.md setfiletype markdown


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
NeoBundle 'thinca/vim-ref'
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
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplcache-snippets-complete'
NeoBundle 'neco-look'
NeoBundle 'html5.vim'
NeoBundle 'HTML5-Syntax-File'
" Google翻訳APIの有料化により利用不可
" NeoBundle 'mattn/googletranslate-vim'
NeoBundle 'mattn/excitetranslate-vim'
NeoBundle 'ZenCoding.vim'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'sudo.vim'
NeoBundle 'tyru/current-func-info.vim'

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

" colorscheme類
NeoBundle 'Wombat'
NeoBundle 'wombat256.vim'

" 自作プラグイン
NeoBundle 'tasuten/gcalc.vim'

" リポジトリを持たないプラグイン
let g:local_plugin_base_path = $HOME.'/.vim/bundle/local/'
" neobundleでpathogenと同等の機能を使用する方法 | karakaram-blog
" http://www.karakaram.com/vim/neobundle120421/
" NeoBundle 'plugin1', {'type' : 'nosync', 'base' : '~/.vim/bundle/local'}
" => .vim/bundle/local/plugin1/(plugin|doc|autoload|...)
" rsense.vim
NeoBundle 'rsense.vim', {'type' : 'nosync', 'base' : g:local_plugin_base_path}
" 今のところ雑多な自作プラグイン等は全部まとめてmypluginに放り込んでる
NeoBundle 'myplugin', {'type' : 'nosync', 'base' : g:local_plugin_base_path}

filetype plugin indent on

" NeoBundleここまで


" open-browser.vim
" wはWebから''
nmap <Leader>w <Plug>(openbrowser-open)
vmap <Leader>w <Plug>(openbrowser-open)

" quickrun
if !exists('g:quickrun_config')
  let g:quickrun_config= {}
endif
" HTMLの場合openで開くようにする
let g:quickrun_config.html = { 'command' : 'open', 'exec' : ['%c %s'] }
" Javaの文字化け対策
let g:quickrun_config.java = { 'exec': ['javac -J-Dfile.encoding=UTF-8 %o %s', '%c -Dfile.encoding=UTF-8 %s:t:r %a', ':call delete("%S:t:r.class")'] }
" Markdown
let g:quickrun_config.markdown = {
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
inoremap <expr><C-l>     neocomplcache#complete_common_string()

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
inoremap <expr><C-e>  neocomplcache#cancel_popup()

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
let g:rsenseUseOmniFunc = 1
if filereadable(expand('/usr/local/bin/rsense'))
  let g:rsenseHome = expand(substitute(system('brew --prefix rsense'), '\n', '', 'g').'/libexec')
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
endif

" neocomplcacheここまで

" ZenCoding.vim
let g:user_zen_settings = { 'indentation':'  ' }

" scheme.vim（Gauche向けシンタックスファイル。~/.vim/syntax/scheme.vim）
" http://legacy.e.tir.jp/wiliki?vim%3Ascheme.vim
autocmd FileType scheme :let is_gauche=1

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
" 常用セット（？）
nnoremap <silent> [unite]u :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

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
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
" au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
" au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" unite.vimここまで

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

" プラグイン設定ここまで

" （colorschemeにかかわらず適用させたい）ハイライト設定
" colorschemeするとこれらの設定が消されるそうなのでcolorschemeの設定はこれより前で行うこと

" 全角スペースを視覚化
" 全角スペースをライトブルーのアンダーラインで表す
" 行末の空白文字をハイライト
" 参考:
" http://d.hatena.ne.jp/piropiropiroshki/20100321/1269119181
" http://mugijiru.seesaa.net/article/203066121.html
" http://vim-users.jp/2009/07/hack40/
augroup MyHighlight
  autocmd!
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
  highlight WhitespaceEOL ctermbg=red guibg=red
  autocmd VimEnter,WinEnter * let w:m1 = matchadd('ZenkakuSpace', '　')
  autocmd VimEnter,WinEnter  * let w:m2 =  matchadd('WhitespaceEOL', '\s\+$')
augroup END

" （colorschemeにかかわらず適用させたい）ハイライト設定ここまで

" statusline
" statuslineを常に表示
set laststatus=2
"大体こんな感じで表示
" hoge.c [+][utf-8:LF][c]               [main()]  0,0-1    全て
" help.jax [ヘルプ][-][RO][utf-8:LF][help]        1,1      先頭
let ff_table = {'dos' : 'CR+LF', 'unix' : 'LF', 'mac' : 'CR' }
let &statusline='%<%f %h%m%r%w[%{(&fenc!=""?&fenc:&enc)}:%{ff_table[&ff]}]%y%=%{Cfi_warpper()}  %-14.(%l,%c%V%) %P'



let g:hatena_user = 'tasuten'

