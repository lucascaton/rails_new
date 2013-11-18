require 'spec_helper'
require 'erb'

describe 'files' do
  describe 'Gemfile' do
    before do
      stub!(:database_adapter).and_return('pg')
    end

    it 'has the correct source' do
      expect(read_template).to match(%r{source 'https://rubygems.org'})
    end

    it 'has the correct Ruby version' do
      expect(read_template).to match(%r{ruby '2.0.0'})
    end

    it 'includes haml-rails gem' do
      @haml = true
      expect(read_template).to match(%r{gem 'haml-rails'})
    end

    it 'does not include haml-rails gem' do
      @haml = false
      expect(read_template).to_not match(%r{gem 'haml-rails'})
    end

    it 'includes twitter-bootstrap-rails gems' do
      @twitter_bootstrap = true
      [%r{therubyracer}, %r{less-rails}, %r{twitter-bootstrap-rails}].each do |group|
        expect(read_template).to match(group)
      end
    end

    it 'does not include twitter-bootstrap-rails gems' do
      @twitter_bootstrap = false
      [%r{therubyracer}, %r{less-rails}, %r{twitter-bootstrap-rails}].each do |group|
        expect(read_template).to_not match(group)
      end
    end

    it 'includes database adapter gem' do
      expect(read_template).to match(%r{gem 'pg'})
    end
  end

  describe '.gitignore' do
    before do
      stub!(:database_adapter)
    end

    it 'has the correct information' do
      expect(read_template).to match(%r{# See http://help.github.com/ignore-files/ for more about ignoring files.})
    end

    it 'includes sqlite3 files' do
      stub!(:database_adapter).and_return('sqlite3')
      expect(read_template).to match(%r{/db/\*.sqlite3})
    end

    it 'does not include sqlite3 files' do
      stub!(:database_adapter).and_return('pg')
      expect(read_template).to_not match(%r{/db/\*.sqlite3})
    end
  end

  describe 'config/database.yml' do
    before do
      stub!(:database_yaml_adapter)
      stub!(:database_encoding)
    end

    it 'has the correct YAML groups' do
      [%r{defaults: &defaults}, %r{development:}, %r{test:}, %r{production:}].each do |group|
        expect(read_template).to match(group)
      end
    end

    it 'has the default keys' do
      [%r{pool: 5}].each do |key|
        expect(read_template).to match(key)
      end
    end

    it 'includes the database adapter key' do
      stub!(:database_yaml_adapter).and_return('postgresql')
      expect(read_template).to match(%r{adapter: postgresql})
    end

    it 'includes the database encoding key' do
      stub!(:database_encoding).and_return('utf8')
      expect(read_template).to match(%r{encoding: utf8})
    end

    it 'does not include the database encoding key' do
      stub!(:database_encoding).and_return(nil)
      expect(read_template).to_not match(%r{encoding:})
    end

    it 'includes the reconnect key' do
      stub!(:database_yaml_adapter).and_return('mysql2')
      expect(read_template).to match(%r{reconnect: false})
    end

    it 'does not include the reconnect key' do
      stub!(:database_yaml_adapter).and_return('postgresql')
      expect(read_template).to_not match(%r{reconnect:})
    end

    it 'includes the timeout key' do
      stub!(:database_yaml_adapter).and_return('sqlite3')
      expect(read_template).to match(%r{timeout: 5000})
    end

    it 'does not include the timeout key' do
      stub!(:database_yaml_adapter).and_return('postgresql')
      expect(read_template).to_not match(%r{timeout:})
    end

    it 'has the username and password keys' do
      stub!(:database_yaml_adapter).and_return('postgresql')
      [%r{username:}, %r{password:}].each do |key|
        expect(read_template).to match(key)
      end
    end

    it 'has no the username and password keys' do
      stub!(:database_yaml_adapter).and_return('sqlite3')
      [%r{username:}, %r{password:}].each do |key|
        expect(read_template).to_not match(key)
      end
    end

    it 'includes the socket key' do
      stub!(:database_yaml_adapter).and_return('mysql2')
      expect(read_template).to match(%r{socket: /tmp/mysql.sock})
    end

    it 'does not include the socket key' do
      stub!(:database_yaml_adapter).and_return('postgresql')
      expect(read_template).to_not match(%r{socket:})
    end

    it 'includes the sqlite databases' do
      stub!(:database_yaml_adapter).and_return('sqlite3')
      [%r{database: db/development.sqlite3}, %r{database: db/test.sqlite3}, %r{database: db/production.sqlite3}].each do |database_name|
        expect(read_template).to match(database_name)
      end
    end

    it 'includes the databases keys' do
      stub!(:database_yaml_adapter).and_return('postgresql')
      @app_name = 'application_name'
      [%r{database: application_name_development}, %r{database: application_name_test}, %r{database: application_name}].each do |database_name|
        expect(read_template).to match(database_name)
      end
    end
  end
end
