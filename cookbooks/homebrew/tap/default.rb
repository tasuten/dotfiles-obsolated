node[:taps].each do |tap|
  tapped = `brew tap`.split
  next if tapped.include?(tap)
  execute "Tap #{tap}" do
    command "brew tap #{tap}"
  end
end
