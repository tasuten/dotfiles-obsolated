define :cask_install do
  system "brew cask install #{params[:name]}" unless Dir.exist?("/usr/local/Caskroom/#{params[:name]}")
end

path = File.expand_path(node[:homebrew][:casks])

File.open(path).each_line do |line|
  cask_install line.chomp
end

