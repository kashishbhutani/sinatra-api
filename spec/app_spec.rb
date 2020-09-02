require 'spec_helper'
require './app.rb'

RSpec.describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "App Routes" do

    it "says welcome to sinatra" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Welcome To Sinatra !')
    end
    
  end

end