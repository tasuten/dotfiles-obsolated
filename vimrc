scriptencoding utf-8

" autocmd vimrcはgroupに属させたほうが良い
" http://rbtnn.hateblo.jp/entry/2014/11/30/174749
augroup vimrc
  autocmd!
augroup END

runtime! conf.d/base/*.vim
runtime! conf.d/plugins/*.vim

