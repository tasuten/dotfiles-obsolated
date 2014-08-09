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
set listchars=tab:»\ 
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

" クリップボードからの貼り付け
inoremap <silent> <C-r>* <C-o>:set paste<CR><C-r>*<C-o>:set nopaste<CR>
inoremap <silent> <C-r>+ <C-o>:set paste<CR><C-r>+<C-o>:set nopaste<CR>

" 検索結果のハイライトを<C-g>でトグル(C-gにしたのはhの1つ左にあったから)
" http://stackoverflow.com/questions/99161/how-do-you-make-vim-unhighlight-what-you-searched-for
nnoremap <silent> <C-g> :set hlsearch!<CR>

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
for n in range(1, 9)
  execute 'nnoremap <silent> [tab]'.n  ':<C-u>tabnext '.n.'<CR>'
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
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen
    let g:qfix_win = bufnr("$")
  endif
endfunction
nnoremap <silent> <Space>q :QFixToggle<CR>

" <Space>sでスクラッチファイルを開く。:ScratchはKaoriYa同梱
nnoremap <Space>s :Scratch<CR>

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

" *.mdなファイルのfiletypeををmodula2ではなくmarkdownとする
autocmd BufNewFile,BufRead *.md setfiletype markdown

" TeXは全てLaTeXと見做す
let g:tex_flavor = "latex"

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

" Vimで shebang 付ファイルを保存時に実行権限を自動で付加する
" http://d.hatena.ne.jp/spiritloose/20060519/1147970872 より
autocmd BufWritePost * :call AddExecmod()
function AddExecmod()
    let line = getline(1)
    if strpart(line, 0, 2) == "#!"
        call system("chmod +x ". expand("%"))
    endif
endfunction


" ここからプラグイン設定

" NeoBundle
" set nocompatible               " be iMproved
filetype off                   " required!
filetype plugin indent off     " required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'matchit.zip'
NeoBundle 'tyru/caw.vim'
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
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'nishigori/increment-activator'
NeoBundle 'thinca/vim-template'
NeoBundle 'camelcasemotion'
NeoBundle 'thinca/vim-prettyprint'
NeoBundle 't9md/vim-quickhl'
" なお、smartinputは<BS>や<Enter>にマッピングを行うが
" 多くの場合他のプラグインで上書きされてて無効になってる
NeoBundle 'kana/vim-smartinput'
NeoBundle 'rhysd/clever-f.vim'
NeoBundleLazy 'mattn/lisper-vim'
" neocomplete, vimproc必須。uniteは有った方が良い
" また、Gauche必須
NeoBundle 'aharisu/vim-gdev'
" 要python
NeoBundle 'sjl/gundo.vim'

" text-object
NeoBundle 'kana/vim-textobj-user'
" 以下i, a以降のキーのみ示す。ちなみにaはオブジェクト全体、iはその"内側"
" 例（削除の例）: da → dida/dada
" コメント。c
NeoBundle 'thinca/vim-textobj-comment'
" 日本語の括弧類。（）はjbかj(かj)、「」はjk、『』はjK、【】はjs
NeoBundle 'kana/vim-textobj-jabraces'
" あるsyntaxと、またあるsyntaxで囲まれた範囲。q
" 例としてRubyやPerlの正規表現リテラルなど
" 詳しくはhttp://d.hatena.ne.jp/deris/20121209/1355048075 参照
NeoBundle 'deris/vim-textobj-enclosedsyntax'
" URL。u
NeoBundle 'mattn/vim-textobj-url'
" Rubyのブロック。r
NeoBundle 'rhysd/vim-textobj-ruby'
" PHPのタグ内。例えば<?から?>まで。P
NeoBundle 'akiyan/vim-textobj-php'
" surround.vim。囲ってる文字を消したり(ds")変えたり(cs"')、
" 新たに囲んだり(ys<範囲><囲むの>, eg.)yss})
NeoBundle 'tpope/vim-surround'

" ref
NeoBundle 'thinca/vim-ref'
NeoBundle 'pekepeke/ref-javadoc'

" neocomplete
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'ujihisa/neco-look'

" unite.vimとそのsource類
" https://github.com/Shougo/unite.vim/wiki/unite-plugins とか参考になるかと
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tsukkee/unite-help'
NeoBundle 'osyo-manga/unite-filetype'
" colorschemeを変更するsource
" -auto-previewと組み合わせると便利かもしれない、とのこと
NeoBundle 'ujihisa/unite-colorscheme'
" Codicというソフトウェア開発者用和英辞書サービスにアクセスする
" プラグインとsource
NeoBundle 'koron/codic-vim'
NeoBundle 'rhysd/unite-codic.vim'
" これ以外にもvim-refにもuniteのsourceが付属。:Unite ref/refeのように使用
" Uniteについては、Unite本体についてくるUnite-findやUnite-grepがすごく便利そう

" filetype類
NeoBundle 'thinca/vim-ft-clojure'
NeoBundle 'javacomplete', {
    \ 'build' : {
    \ 'mac' : 'javac autoload/Reflection.java',
    \ 'unix' : 'javac autoload/Reflection.java',
    \ },
  \ }
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'https://bitbucket.org/teramako/jscomplete-vim.git'
" vim-ft-clojureの方にも虹色ハイライトあるけど読み込み順的にこっちが有効か
NeoBundle 'amdt/vim-niji'

" colorscheme類
NeoBundle 'nanotech/jellybeans.vim'
" statusline
NeoBundle 'itchyny/lightline.vim'

" 自作プラグイン
NeoBundle 'tasuten/gcalc.vim'

" リポジトリを持たないプラグイン
" 自作プラグインを neobundle.vim で管理する - C++でゲームプログラミング
" http://d.hatena.ne.jp/osyo-manga/20131022/1382426403
let g:local_plugin_base_path = $HOME.'/.vim/local_bundle/'
command! -nargs=1 NeoBundleLocalPlugin
      \   NeoBundle <args>, {
      \       "base" : g:local_plugin_base_path,
      \       "type" : "nosync",
      \   }
command! -nargs=1 NeoBundleLocalPluginLazy
      \   NeoBundleLazy <args>, {
      \       "base" : g:local_plugin_base_path,
      \       "type" : "nosync",
      \   }
" rsense.vim
NeoBundleLocalPluginLazy 'rsense.vim'
" vim:scheme.vim http://legacy.e.tir.jp/wiliki?vim%3ascheme.vim#H-xl1p5w の
" Gauche用シンタックスファイル
NeoBundleLocalPlugin 'gauche-syntax'
" https://github.com/sophacles/vim-processing を自分用に弄ったもの
NeoBundleLocalPlugin 'vim-processing'

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
" markdownではvimprocによる非同期実行が遅いのでその設定を無効化
let g:quickrun_config.markdown = {
      \ 'runner' : 'system',
      \ 'type' : 'markdown/redcarpet',
      \ 'outputter' : 'browser'
      \ }
" (La)TeX
"LaTeXをquickrunで楽に処理する - プログラムモグモグ
" http://d.hatena.ne.jp/itchyny/20121001/1349094989
" 等参考。viewtexは~/bin/に
let g:quickrun_config.tex = { 'command' : 'viewtex' }
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
" \  'vimshell' : $HOME.'/.vimshell_hist',
" の行を少し書き換えた
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell/command-history'
      \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
" 英字のみキャッシュする
let g:neocomplete#keyword_patterns.default = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
"" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  " return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()

" AutoComplPop like behavior.
" let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
" set completeopt+=longest
" let g:neocomplete#enable_auto_select = 1
" let g:neocomplete#disable_auto_complete = 1
" inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
" inoremap <expr><CR>  neocomplete#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
" let g:neocomplete#sources#omni#input_patterns.ruby = ''
" let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplete#sources#omni#input_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.java = '\%(\.\)\h\w*'

" include補完
if !exists('g:neocomplete#sources#include#paths')
  let g:neocomplete#sources#include#paths = {}
endif
let g:neocomplete#sources#include#paths.c  =  '/usr/include,'.'/usr/local/include'

" rsense
" 補記:neocompleteで補完されない時は
" 何度かやってみるかオムニ補完(<C-x><C-o>)でやるといいかも
" if !exists('g:neocomplete#sources#omni#input_patterns')
"  let g:neocomplete#sources#omni#input_patterns = {}
" endif
" let g:rsenseUseOmniFunc = 1
" if filereadable(expand('/usr/local/bin/rsense'))
  " let g:rsenseHome = expand(substitute(system('brew --prefix rsense'), '\n', '', 'g').'/libexec')
  " let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" endif

" clang_completeの補完をneocompleteで
" http://d.hatena.ne.jp/osyo-manga/20120911/1347354707 より
" neocomplete 側の設定
let g:neocomplete#force_overwrite_completefunc=1
if !exists("g:neocomplete#force_omni_input_patterns")
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
" SuperTab like snippets behavior.
" imap <expr><TAB> neosippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
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

" scheme.vim（Gauche向けシンタックスファイル。~/.vim/syntax/scheme.vim）
" http://legacy.e.tir.jp/wiliki?vim%3Ascheme.vim
autocmd FileType scheme :let is_gauche=1

" ref.vim
" ref-javadoc
" ローカルのパスでないとダメ
let g:ref_javadoc_path = '/usr/local/java6_ja_apidocs/'
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
nnoremap [doc]jd :<C-u>Ref<Space>javadoc<Space>
" ref.vim/webdict
nnoremap [doc]wp :<C-u>Ref<Space>webdict<Space>wikipedia<Space>
nnoremap [doc]wt :<C-u>Ref<Space>webdict<Space>wiktionary<Space>
nnoremap [doc]je :<C-u>Ref<Space>webdict<Space>je<Space>
nnoremap [doc]ej :<C-u>Ref<Space>webdict<Space>ej<Space>
" ref.vimでは無いけどUnite + vim-gdevでgaucheのシンボル検索
nnoremap [doc]ga :<C-u>Unite<Space>gosh_all_symbol<CR>
" 同じくref.vimではないけどcodic-vimのunite source
nnoremap [doc]co :<C-u>Unite<Space>codic<CR>

" unite.vim
" http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin を参考にした

" The prefix key.
nnoremap [unite] <Nop>
nmap s [unite]

" 入力モードで開始する
let g:unite_enable_start_insert=1

" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" source一覧
nnoremap <silent> [unite]e :<C-u>Unite source<CR>

" Unite grep
nnoremap [unite]g :<C-u>Unite grep -buffer-name=grep -no-quit -auto-preview<CR>
" バッファ内の行検索
nnoremap [unite]l :<C-u>Unite -buffer-name=search line -start-insert<CR>

" Unite outline
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
" Unite help
nnoremap <silent> [unite]h :<C-u>Unite help<CR>
" Unite filetype
nnoremap <silent> [unite]t :<C-u>Unite filetype<CR>
" Unite colorscheme
nnoremap <silent> [unite]cm :<C-u>Unite colorscheme -auto-preview<CR>

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

" yankround.vim
" YankRing likeなキーバインド
" <C-p/n>は<C-u/d>に変更してる
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-u> <Plug>(yankround-prev)
nmap <C-d> <Plug>(yankround-next)
" キャッシュの保存先
let g:yankround_dir = '~/.cache/yankround'

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
      \ ]
      \ }

" quickhl.vim
" カーソル下の単語のハイライトをトグル
nmap <Leader>m <Plug>(quickhl-manual-this)
xmap <Leader>m <Plug>(quickhl-manual-this)
" 全てのハイライトをクリア
nmap <Leader>M <Plug>(quickhl-manual-reset)
xmap <Leader>M <Plug>(quickhl-manual-reset)

" vim-smartinput
" <や>に関する設定
" >をトリガとして設定
call smartinput#map_to_trigger('i', '>', '>', '>')
" <> で<><Left>。<で>を補完しないのは不等号の入力時などを考え
call smartinput#define_rule({'at': '<\%#', 'char': '>', 'input': '><Left>'})
" <>内にいる時>で<>の外に脱出
call smartinput#define_rule({'at': '\%#\_s*>', 'char': '>', 'input': '<C-r>=smartinput#_leave_block(''>'')<Enter><Right>'})

" clever-f.vim
" f{小文字}では両方に、f{大文字}では大文字のみにヒットする
let g:clever_f_smart_case = 1
" F{char}の時でもfは右方向に、Fは左方向に移動する
let g:clever_f_fix_key_direction = 1
" f;で任意の記号にマッチする
let g:clever_f_chars_match_any_signs = ';'

" gundo.vim
nnoremap U :<C-u>GundoToggle<CR>

" jscomplete-vim
" DOM APIも補完対象に
let g:jscomplete_use = ['dom']

" プラグイン設定ここまで


" colorscheme設定

" jellybeans
" 背景色を濃い灰色ではなく黒にする
let g:jellybeans_background_color_256 = 0
let g:jellybeans_background_color = "000000"
" 1.[Tab]なんかの色(SpecialKey)も背景黒、文字はgrayで
" 2.CursorLineの行の行番号は、CursorLineと同じ感じに
" 3.対応する括弧の色を？山吹色背景黒文字に変更
" 不思議な事にCUIのVimでも何故かgui*の方が適用されてる
let g:jellybeans_overrides = {
      \    'SpecialKey' : {
      \              'guifg': '707070', 'guibg': '000000',
      \              'ctermfg': 'gray', 'ctermbg': 'black',
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

" UniteやVimShell、Netrw、Gundoの時modeやfilenameをちょっと細工する
let g:lightline.component_function = {
      \ 'mode'     : 'MyMode',
      \ 'filename' : 'MyFilename',
      \ }

function! MyMode()
  let fname = expand('%:t')
  return  &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ &ft == 'netrw' ? 'Netrw' :
        \ &ft == 'gundo' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo-P' :
        \ lightline#mode()
endfunction

function! MyFilename()
  let fname = expand('%:t')
  " netrwでは開いているディレクトリを表示
  return  &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ &ft == 'netrw' ? substitute(getline(3), '"\s\+', '', 'g') :
        \ (fname == '__Gundo__' || fname == '__Gundo_Preview__') ? '' :
        \ '' != fname ? fname : '[No Name]'
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" readonlyがfilenameより左に表示されるのが気になったので
let g:lightline.active = {
      \ 'left' : [['mode', 'paste'], ['filename', 'modified', 'readonly']]
      \ }


let g:hatena_user = 'tasuten'

