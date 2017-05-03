execute 'Install Homebrew' do
  user node[:user]
  command '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  not_if "which brew"
end
