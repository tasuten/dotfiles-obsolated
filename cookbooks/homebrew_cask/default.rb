define :cask_install do
  entity = "/usr/local/Caskroom/#{params[:name]}"
  system "brew cask install #{params[:name]}" unless Dir.exist?(entity)
end

path = File.expand_path(node[:homebrew][:casks])

File.open(path).each_line do |line|
  cask_install line.chomp
end