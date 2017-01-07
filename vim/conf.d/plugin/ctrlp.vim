" <C-p>はyankroundに使うので代わりに<C-e>を使う
let g:ctrlp_map = '<C-e>'
" 隠しファイルも表示する
let g:ctrlp_show_hidden = 1
" キーマッピングの微調整
if !exists('g:ctrlp_prompt_mappings')
  let g:ctrlp_prompt_mappings = {}
endif
" CTRL-hを水平分割で開くに割当
let g:ctrlp_prompt_mappings['AcceptSelection("h")'] = [ '<C-h>' ]
" CTRL-k/jで履歴をbackward/forwardに遡る
let g:ctrlp_prompt_mappings['PrtHistory(1)'] = [ '<C-k>' ]
let g:ctrlp_prompt_mappings['PrtHistory(-1)'] = [ '<C-j>' ]
" CTRL-p/nで上/下の候補の選択
let g:ctrlp_prompt_mappings['PrtSelectMove("j")'] = [ '<C-n>' ]
let g:ctrlp_prompt_mappings['PrtSelectMove("k")'] = [ '<C-p>' ]
" 表示リストの各項目の頭の文字を「> 」から変更
let g:ctrlp_line_prefix = ' '
" core typeはファイル検索のみにする
let g:ctrlp_types = [ 'fil' ]
" The prefix key
nnoremap [ctrlp] <Nop>
nmap e [ctrlp]
" 行
nnoremap <silent> [ctrlp]l :CtrlPLine<CR>
" QuickFix
nnoremap <silent> [ctrlp]q :CtrlPQuickfix<CR>
" アウトライン(ctrlp-funky)
nnoremap <silent> [ctrlp]f :CtrlPFunky<CR>
" テンプレート(ctrlp-sonictemplate)
nnoremap <silent> [ctrlp]t :CtrlPSonictemplate<CR>

