node[:taps].each do |tap|
  tapped = `brew tap`.split
  unless tapped.include?(tap)
    execute "Tap #{tap}" do
      command "brew tap #{tap}"
    end
  end
end
