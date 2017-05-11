# common settings that is not related platform

define :dotfile, add_dot: false do
  entity = params[:name]
  symlink = params[:add_dot] ? ".#{entity}" : entity

  link_root = ENV['HOME']

  link File.join(link_root, symlink) do
    to File.expand_path("../../dotfiles/#{entity}", __FILE__)
  end
end
