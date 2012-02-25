class RailsTemplates < Thor
  include Thor::Actions

  desc 'default', 'Create a new Rails app using a custom template'
  def default(args)
    puts 'Creating a new Rails app...'
    app_path = args.split.first
    app_name = app_path.split('/').last

    system "rails new #{args} --skip-bundle"
    system "cd #{app_path} && bundle check"
    # create_file 'test.txt', 'content...'

    puts 'Done!'
  end
end
