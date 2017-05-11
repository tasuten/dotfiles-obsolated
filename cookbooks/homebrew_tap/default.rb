define :tap do
  entity = "/usr/local/Homebrew/Library/Taps/#{params[:name]}"
  system "brew tap #{params[:name]}" unless Dir.exist?(entity)
end

path = File.expand_path(node[:homebrew][:taps])

File.open(path).each_line do |line|
  tap line.chomp
end
