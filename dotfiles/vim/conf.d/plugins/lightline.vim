" statusline
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

