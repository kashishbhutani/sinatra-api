ENV['APP_ENV'] = 'development'

require 'sinatra'

class App < Sinatra::Base

    get '/' do
        'Welcome To Sinatra !'
    end
    
end