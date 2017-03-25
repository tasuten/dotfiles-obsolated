" ユーザ定義のハイライトグループ
" ZenkakuSpace: 全角スペース
" WhitespaceEOL: 行末のスペース
autocmd vimrc ColorScheme * call s:my_highlights()
function! s:my_highlights()
  let w:m1 = matchadd('ZenkakuSpace', '　')
  let w:m2 = matchadd('WhitespaceEOL', '\s\+$')
endfunction

if !exists('g:machiya_customize')
  let g:machiya_customize = {}
endif
let g:machiya_customize.ZenkakuSpace = {
\ 'ctermfg': 218, 'cterm' : 'underline',
\ 'guifg': '#e7a5c9', 'gui' : 'underline'
\ }
let g:machiya_customize.WhitespaceEOL = { 'ctermbg' : 218, 'guibg' : '#e7a5c9' }

" ターミナルエミュレータの背景色に合わせる
let g:machiya_use_terminal_background_color = 1

" colorschemeの適用
colorscheme machiya

