class RailsTemplates < Thor
  include Thor::Actions

  desc 'default', 'Create a new Rails app using a custom template'
  def default(app_name)
    puts 'Creating a new Rails app...'
    system "rails new #{app_name} -d postgresql"
    # create_file 'test.txt', 'content...'
  end
end
