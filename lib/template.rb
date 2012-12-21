def yes?(question)
  return true unless @customized

  answer = ask "     \e[1m\e[32mpromp".rjust(10) + "  \e[0m#{question} \e[33m(y/n)\e[0m"
  case answer.downcase
  when 'yes', 'y' then true
  when 'no',  'n' then false
  else yes?(question)
  end
end

def prompt(question, options)
  answer = ask("     \e[1m\e[32mpromp".rjust(10) + "  \e[0m#{question} \e[33m[#{options[:default_answer]}]\e[0m").strip
  answer.present? ? answer : options[:default_answer]
end

def apply_template(file)
  template "#{File.dirname(__FILE__)}/files/#{file}.erb", file, force: true
  system "sed '/^$/N;/^\\n$/D' #{file} > sed_output" # remove duplicated empty lines
  system "mv sed_output #{file}"
end

def commit(description)
  system 'git add .'
  system 'git add --update .'
  system "git commit -am '#{description}'"
end

def database_adapter
  case @database
  when 'postgresql', 'postgres', 'psql' then 'pg'
  when 'mysql'                          then 'mysql2'
  when 'sqlite'                         then 'sqlite3'
  when 'mongo', 'mongodb'               then 'mongoid'
  else @database
  end
end

def database_encoding
  case database_adapter
  when 'pg'     then 'unicode'
  when 'mysql2' then 'utf8'
  end
end


@app_name   = `pwd`.gsub(/.*\/(.+)/, '\1').strip
@customized = true

@database            = prompt 'What database you want to use?', default_answer: 'postgresql'
@customized          = yes? 'Would you like to customize the template options?'
@create_commits      = yes? 'Create first git commits?'
@static_pages        = yes? 'Create static pages?'
@haml                = yes? 'Use HAML?'
@pt_br_locales       = yes? 'Use brazilian portuguese locale (I18n)?'
@twitter_bootstrap   = yes? 'Install and configure Twitter Bootstrap Rails gem?'
# @devise              = yes? 'Install and configure Devise gem?'


remove_file 'public/index.html'
remove_file 'app/assets/images/rails.png'

apply_template 'Gemfile'
apply_template '.gitignore'
apply_template 'config/database.yml'

system 'bundle install'

if @create_commits
  system 'git init'
  commit 'Initial Rails directory structure'
end

if @pt_br_locales
  remove_file 'config/locales/en.yml'
  # Include config/locales*.pt-BR.yml files
  # Update config/application.rb
  commit 'Including pt-br locales' if @create_commits
end

if @twitter_bootstrap
  system 'rails generate bootstrap:install less'
  system 'rails generate bootstrap:layout application'
  commit 'Installing twitter bootstrap gem' if @create_commits
end

if @static_pages
  if @twitter_bootstrap
  else
  end
end
