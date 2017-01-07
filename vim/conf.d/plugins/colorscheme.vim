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

