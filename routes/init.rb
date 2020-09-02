# All application routes will be initialized here.

require_relative './posts'
require_relative './users'

#GET / | Home
get '/' do
    'Welcome To Sinatra !'
end