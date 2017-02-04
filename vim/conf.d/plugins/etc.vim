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

" caw.vim
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

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

" yankround.vim
" YankRing likeなキーバインド
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
" キャッシュの保存先
let g:yankround_dir = '~/.cache/yankround'

" sonictemplate-vim
let g:sonictemplate_vim_template_dir = [
\ $HOME.'/.vim/template',
\ ]

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


" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)

" indentLine
" See: https://github.com/Yggdroot/indentLine/issues/125
let g:indentLine_concealcursor = ''
" helpでは無効にする
let g:indentLine_fileTypeExclude = [ 'help' ]


" gundo.vim
nnoremap U :<C-u>GundoToggle<CR>
autocmd vimrc FileType gundo nnoremap <buffer> :q :<C-u>GundoHide<CR>
autocmd vimrc BufNewFile,BufRead __Gundo_Preview__ nnoremap <buffer> :q :<C-u>GundoHide<CR>

" vivi.vim
" iexを立ち上げとく。refやomni補完を使うときに便利
let g:vivi_enable_auto_warm_up_iex = 1
" omni補完
let g:vivi_enable_omni_completion = 1

" vim-racer
let g:racer_experimental_completer = 1

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

