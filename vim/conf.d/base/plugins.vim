" vim-plug

call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'thinca/vim-quickrun'
" vim-watchdogs depend_on quickrun, vimproc, shabadou.vim
Plug 'osyo-manga/shabadou.vim' | Plug 'osyo-manga/vim-watchdogs'
Plug 'tyru/caw.vim'
Plug 'tyru/open-browser.vim'
Plug 'mattn/webapi-vim'
Plug 'LeafCage/yankround.vim'
Plug 'nishigori/increment-activator'
Plug 'mattn/sonictemplate-vim'
Plug 'thinca/vim-prettyprint'
Plug 'haya14busa/incsearch.vim'
Plug 'cohama/lexima.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Yggdroot/indentLine'
Plug 'ConradIrwin/vim-bracketed-paste'
if has('python') || has('python3')
  Plug 'sjl/gundo.vim'
  Plug 'editorconfig/editorconfig-vim'
endif
Plug 'vim-scripts/matchit.zip'

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
if has('lua')
  Plug 'Shougo/neocomplete'
  Plug 'ujihisa/neco-look'
  Plug 'Shougo/neco-vim', { 'for' : 'vim' }
endif
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'kaneshin/ctrlp-sonictemplate'

" filetype類
Plug 'elixir-lang/vim-elixir', { 'for' : 'elixir' }
Plug 'liquidz/vivi.vim', { 'for' : 'elixir' }
Plug 'rust-lang/rust.vim', { 'for' : 'rust' }
Plug 'racer-rust/vim-racer', { 'for' : 'rust' }
Plug 'fatih/vim-go', { 'for' : 'go' }
Plug 'dag/vim-fish', { 'for' : 'fish' }
Plug 'keith/tmux.vim', { 'for' : 'tmux' }
Plug 'spinningarrow/vim-niji', { 'for' : [ 'lisp', 'scheme', 'clojure' ] }

" colorscheme
Plug 'morhetz/gruvbox'
" statusline
Plug 'itchyny/lightline.vim'

" 自作プラグイン
Plug 'tasuten/gcalc.vim'
Plug 'tasuten/motor.vim'

call plug#end()

