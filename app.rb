ENV['APP_ENV'] = 'development'

require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require './models/init' # models

class App < Sinatra::Base

end