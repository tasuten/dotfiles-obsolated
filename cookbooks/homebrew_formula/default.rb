path = File.expand_path(node[:homebrew][:formulas])

File.open(path).each_line do |line|
  parsed = line.split
  name = parsed.shift
  opt = parsed.join(' ')

  package name do
    action :install
    options opt
  end
end
