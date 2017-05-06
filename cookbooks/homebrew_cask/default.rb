define :cask_install do
  system "brew cask install #{params[:name]}" unless Dir.exist?("/usr/local/Caskroom/#{params[:name]}")
end

# cask_install 'firefox'
