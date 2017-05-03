" ユーザ定義のハイライトグループ
" ZenkakuSpace: 全角スペース
" WhitespaceEOL: 行末のスペース
autocmd vimrc ColorScheme * call s:my_highlights()
function! s:my_highlights()
  highlight ZenkakuSpace ctermfg=124 guifg=#cc241d cterm=underline gui=underline
  highlight WhitespaceEOL ctermbg=124 guibg=#cc241d
  let w:m1 = matchadd('ZenkakuSpace', '　')
  let w:m2 = matchadd('WhitespaceEOL', '\s\+$')
endfunction

colorscheme gruvbox

