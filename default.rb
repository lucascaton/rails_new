module Thor::Actions
  def source_paths
    [File.dirname(__FILE__) + '/templates']
  end
end

system('bundle check') || puts("\n=> Installing missing gems..."); system('bundle install')

remove_file 'rm public/index.html'
create_file 'app/assets/images/.gitkeep'
remove_file 'app/assets/images/rails.png'

copy_file 'Gemfile', 'Gemfile', :force => true
