require 'spec_helper'
require './app.rb'

RSpec.describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe "User API Routes" do

    context 'USER #index' do 

        let!(:all_users) { User.all }

        it "sends all users as json" do
            get '/api/v1/users'

            expect(last_response.status).to eq 200
            
            expect(last_response.body).to include(all_users.to_json)
        end

    end

    context 'USER #show' do

        let!(:single_user) { User.last }

        it "should send single user as json" do
            get "/api/v1/users/#{single_user.id}"

            expect(last_response.status).to eq 200

            expect(last_response.body).to include(single_user.to_json)
        end

        context 'ERRORS #show' do

            it "should send user not found message as json" do
                get "/api/v1/users/567"

                expect(last_response.status).to eq 400

                expect(last_response.body).to include("User Not Found!".to_json)
            end

        end

    end

    context 'USER #create' do

        it "should create a new user" do
            params = {
                name: "Testing User",
                mobile: "1234567890",
                email: "kashish@metadesignsolutions.co.uk"
            }

            expect { post "/api/v1/users", params }.to change(User, :count).by(1)

            expect(last_response.status).to eq 201
        end

        context 'ERRORS #create' do

            it "should not create new user with empty name" do
                params = {
                    mobile: "1234567890",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                expect { post "/api/v1/users", params }.to change(User, :count).by(0)

                expect(last_response.body).to include("Name Can't Be Blank!".to_json)

                expect(last_response.status).to eq 400
            end

            it "should not create new user with name of length < 5" do
                params = {
                    name: "Te",
                    mobile: "1234567890",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                expect { post "/api/v1/users", params }.to change(User, :count).by(0)
            end

            it "should not create new user with name of length > 255" do
                params = {
                    name: "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test",
                    mobile: "1234567890",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                expect { post "/api/v1/users", params }.to change(User, :count).by(0)
            end

            it "should not create new user with empty mobile" do
                params = {
                    name: "Testing User",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                expect { post "/api/v1/users", params }.to change(User, :count).by(0)

                expect(last_response.body).to include("Mobile Can't Be Blank!".to_json)

                expect(last_response.status).to eq 400
            end

            it "should not create new user with empty email" do
                params = {
                    name: "Testing User",
                    mobile: "1234567890"
                }

                expect { post "/api/v1/users", params }.to change(User, :count).by(0)

                expect(last_response.body).to include("Email Can't Be Blank!".to_json)

                expect(last_response.status).to eq 400
            end

        end

    end

    context 'USER #update' do

        let!(:update_user) { User.first }
        
        it "should update a user" do
            params = {
                name: "Updating User",
                mobile: "1234567890",
                email: "kashish@metadesignsolutions.co.uk"
            }

            put "/api/v1/users/#{update_user.id}", params

            expect(last_response.status).to eq 201

            update_user.reload

            params.keys.each do |key|
                expect(update_user.attributes[key.to_s]).to eq params[key]
            end
        end

        context 'ERRORS #update' do

            it "should not update user with empty name" do
                params = {
                    name: nil,
                    mobile: "1234567890",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                put "/api/v1/users/#{update_user.id}", params

                expect(last_response.body).to include("Name Can't Be Blank!".to_json)

                expect(last_response.status).to eq 400
            end

            it "should not update user with name of length < 3" do
                params = {
                    name: "Te",
                    mobile: "1234567890",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                put "/api/v1/users/#{update_user.id}", params
            end

            it "should not update user with name of length > 255" do
                params = {
                    name: "Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test",
                    mobile: "1234567890",
                    email: "kashish@metadesignsolutions.co.uk"
                }

                put "/api/v1/users/#{update_user.id}", params
            end

            it "should not update user with empty email" do
                params = {
                    name: "Testing User",
                    mobile: "1234567890",
                    email: nil
                }

                put "/api/v1/users/#{update_user.id}", params

                expect(last_response.body).to include("Email Can't Be Blank!".to_json)

                expect(last_response.status).to eq 400
            end

            it "should not update user with empty mobile" do
                params = {
                    name: "Testing User",
                    mobile: nil,
                    email: "kashish@metadesignsolutions.co.uk"
                }

                put "/api/v1/users/#{update_user.id}", params

                expect(last_response.body).to include("Mobile Can't Be Blank!".to_json)

                expect(last_response.status).to eq 400
            end
        end

    end

    context 'USER #delete' do

        let!(:delete_user) { User.last }

        it "should delete single user" do
            expect { delete "/api/v1/users/#{delete_user.id}" }.to change(User, :count).by(-1)

            expect(last_response.status).to eq 201
        end

        context 'ERRORS #delete' do

            it "should send user not found message as json" do
                expect { delete "/api/v1/users/567" }.to change(User, :count).by(0)

                expect(last_response.status).to eq 400

                expect(last_response.body).to include("User Not Found!".to_json)
            end

        end

    end

  end

end