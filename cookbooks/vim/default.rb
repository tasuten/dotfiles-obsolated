dotfile 'vimrc' do
  add_dot true
end

%w[
  vim/conf.d
  vim/template
  vim/snippets
  vim/ftplugin
].each do |path|
  dotfile path do
    add_dot true
  end
end

execute 'Install vim-plug' do
  url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  plug_path = "#{ENV['HOME']}/.vim/autoload/plug.vim"
  system("curl -fLo #{plug_path} --create-dirs #{url}") unless File.exist?(plug_path)
end
