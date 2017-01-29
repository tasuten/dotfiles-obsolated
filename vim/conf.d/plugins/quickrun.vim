if !exists('g:quickrun_config')
  let g:quickrun_config= {}
endif
" vimprocを用いて非同期に実行する
" updatetimeの指定はこうしないと'updatetime'(デフォルト: 4000ms)待つので
" 成功時にはバッファ、失敗時はquickfixに出す
let g:quickrun_config._ = {
\ 'runner' : 'vimproc',
\ 'runner/vimproc/updatetime' : '10',
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'buffer',
\ 'outputter/error/error'   : 'quickfix',
\ }
" HTMLの場合openで開くようにする
let g:quickrun_config.html = { 'command' : 'open', 'exec' : ['%c %s'] }
" Javaの文字化け対策
let g:quickrun_config.java = { 'exec': ['javac -J-Dfile.encoding=UTF-8 %o %s', '%c -Dfile.encoding=UTF-8 %s:t:r %a', ':call delete("%S:t:r.class")'] }
" Markdown
let g:quickrun_config.markdown = {
\ 'type' : 'markdown/redcarpet',
\ 'outputter' : 'browser'
\ }

" vim-watchdogs
" 保存時、一定時間放置時にチェック
let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_CursorHold_enable = 1

" Rubyでrubocopが使えるならそっちを使う
if executable('rubocop')
  let g:quickrun_config['ruby/watchdogs_checker'] = {
  \   'type' : 'watchdogs_checker/rubocop'
  \ }
endif
call watchdogs#setup(g:quickrun_config)

