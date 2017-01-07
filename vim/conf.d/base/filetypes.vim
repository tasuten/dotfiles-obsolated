filetype on
filetype plugin on
filetype indent on

" TeXは全てLaTeXと見做す
let g:tex_flavor = 'latex'
" TeXのConcealを無効化
let g:tex_conceal = ''

" Vimファイルでの行継続の\の位置を指定
let g:vim_indent_cont = 0

" gitのコミットメッセージ編集時にDでdiffをプレビュー
autocmd vimrc FileType gitcommit nnoremap <buffer> D :DiffGitCached<CR>
autocmd vimrc FileType git nnoremap <buffer> D :q<CR>

" Vimで shebang 付ファイルを保存時に実行権限を自動で付加する
" http://d.hatena.ne.jp/spiritloose/20060519/1147970872 より
autocmd vimrc BufWritePost * :call AddExecmod()
function AddExecmod()
  let line = getline(1)
  if strpart(line, 0, 2) ==# '#!'
    call system('chmod +x '. expand('%'))
  endif
endfunction

