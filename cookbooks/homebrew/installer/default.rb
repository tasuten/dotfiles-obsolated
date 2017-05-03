execute 'Install Homebrew' do
  url = 'https://raw.githubusercontent.com/Homebrew/install/master/install'
  command "ruby -e \"$(curl -fsSL #{url})\""
  not_if 'which brew'
end
