execute "Install Command Line Tools" do
  user node[:user]
  command "xcode-select --install"
  not_if "which gcc"
end
