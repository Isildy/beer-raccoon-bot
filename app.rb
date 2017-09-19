$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'app'))

require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'active_record'
require 'lib/response_formaters/main_response_formater'
require 'sinatra/has_scope'
require 'sinatra/json'
require 'sinatra/param'
require 'yaml'
require 'dotenv'
require 'i18n'


Dotenv.load

Dir.glob(File.join('./app', '**', '*.rb'), &method(:require))

configure do
  I18n.load_path << Dir[File.join(settings.root, 'config', 'locales', '*.yml')]
  I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locales', '*.yml').to_s]
end

dbconfig = YAML.safe_load(ERB.new(File.read('config/database.yml')).result)

RACK_ENV ||= ENV['RACK_ENV'] || 'development'
ActiveRecord::Base.establish_connection dbconfig[RACK_ENV]

