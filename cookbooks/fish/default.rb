dotfile 'config/fish/config.fish' do
  add_dot true
end

dotfile 'config/fish/configs' do
  add_dot true
end

execute 'Install fisherman' do
  command 'curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher'
  not_if 'which fisher'
end

# TODO: package install by fisher
