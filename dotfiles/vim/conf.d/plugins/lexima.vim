" <と>に関するルール
" <>と入力すると<#>とカーソルを真ん中に
" <と入力しただけで>を補完しないのは不等号入力を考えて
call lexima#add_rule({'char': '>', 'at': '<\%#', 'input': '', 'input_after': '>'})
" <#>で>を入力すると<>の外に出る
call lexima#add_rule({'char': '>', 'at': '\%#>',  'leave': '>'})
" <#>で<BS>で<>自体を削除
call lexima#add_rule({'char': '<BS>',  'at': '<\%#>', 'input': '<BS>', 'delete': 1})
" コンマを入力した時に後ろにスペースを付ける
call lexima#add_rule({'char': ',', 'input': ',<Space>'})
" ただし、そのまま改行する場合, の後ろのスペースを削除する
call lexima#add_rule({'char': '<CR>',  'at': ', \%#', 'input': '<BS><CR>'})

" Markdown
" 箇条書きでビュレットの-や*の後ろにスペースを付ける
call lexima#add_rule({'char': '-',  'at': '^\s*\%#$',  'input': '- ', 'filetype': 'markdown'})
call lexima#add_rule({'char': '*',  'at': '^\s*\%#$',  'input': '* ', 'filetype': 'markdown'})
" <BS>で一緒に削除
call lexima#add_rule({'char': '<BS>',  'at': '^\s*- \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
call lexima#add_rule({'char': '<BS>',  'at': '^\s*\* \%#$', 'input': '<BS><BS>', 'filetype': 'markdown'})
" -に関しては連続する場合はヘッダの区切り行なので細工
call lexima#add_rule({'char': '-',  'at': '^- \%#$',  'input': '<BS>-', 'filetype': 'markdown'})
" *についても強調で使うので細工
call lexima#add_rule({'char': '*',  'at': '^\s*\* \%#$',  'input': '<BS>*', 'filetype': 'markdown'})

