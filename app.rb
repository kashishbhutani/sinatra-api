# Setting up App Environment
ENV['APP_ENV'] = 'development'

# sinatra app
require 'sinatra'

# route namespacing
require 'sinatra/namespace'

# debugger for development & test
require 'pry'

# orm for models
require 'sinatra/activerecord'

# database configuration
require './config/environments'

# routes
require './routes/init'

# models
require './models/init'

class App < Sinatra::Base
end