dotfile 'vimrc' do
  add_dot true
end

%w(
vim/conf.d
vim/template
vim/snippets
vim/ftplugin
).each do |path|
  dotfile path do
    add_dot true
  end
end

