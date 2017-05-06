execute 'Install Command Line Tools' do
  command 'xcode-select --install'
  not_if 'which ruby'
end
