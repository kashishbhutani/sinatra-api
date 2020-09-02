ENV['APP_ENV'] = 'development'

require 'sinatra'
require 'sinatra/namespace'
require 'pry'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require './routes/init' # routes
require './models/init' # models

class App < Sinatra::Base

end