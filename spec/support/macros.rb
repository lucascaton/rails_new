def read_template
  file = File.expand_path("../../../lib/files/#{example.metadata[:example_group][:description]}.erb", __FILE__)
  ERB.new(File.new(file).read, nil, '%').result(binding)
end
