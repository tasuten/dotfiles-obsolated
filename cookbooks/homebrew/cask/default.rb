node[:casks].each do |cask|
  installed = `brew cask list`.split
  next if installed.include?(cask)
  execute "Install #{cask}" do
    command "brew cask install #{cask}"
  end
end
