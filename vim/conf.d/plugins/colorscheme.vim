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
\ 'ctermfg': 175, 'cterm' : 'underline',
\ 'guifg': '#db7bb1', 'gui' : 'underline'
\ }
let g:machiya_customize.WhitespaceEOL = { 'ctermbg' : 175, 'guibg' : '#db7bb1' }

" ターミナルエミュレータの背景色に合わせる
let g:machiya_use_terminal_background_color = 1

" colorschemeの適用
colorscheme machiya

