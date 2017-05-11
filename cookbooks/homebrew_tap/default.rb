define :tap do
  system "brew tap #{params[:name]}" unless Dir.exist?("/usr/local/Homebrew/Library/Taps/#{params[:name]}")
end

# tap "foo/bar"
