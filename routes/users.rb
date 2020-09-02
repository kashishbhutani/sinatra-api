#Users API(Version 1)

namespace '/api/v1' do

    #GET /api/v1/users | Index
    get '/users' do
        User.all.to_json
    end
    
    #GET /api/v1/users/:id | Show
    get '/users/:id' do
        begin
            user = User.find_by_id(params[:id])
        
            raise Exception, "User Not Found!" if user.nil?
            
            user.to_json
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end
    
    #POST /api/v1/users | Create
    post '/users' do
        begin
            raise Exception, "Name Can't Be Blank!" unless params[:name].present?

            raise Exception, "Mobile Can't Be Blank!" unless params[:mobile].present?

            raise Exception, "Email Can't Be Blank!" unless params[:email].present?

            halt 500 unless User.create(
                name: params[:name],
                mobile: params[:mobile],
                email: params[:email]
            )
    
            status 201
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end

    #PUT /api/v1/users/:id | Update
    put '/users/:id' do
        begin
            user = User.find_by_id(params[:id])
      
            raise Exception, "User Not Found!" if user.nil?

            raise Exception, "Name Can't Be Blank!" unless params[:name].present?

            raise Exception, "Mobile Can't Be Blank!" unless params[:mobile].present?

            raise Exception, "Email Can't Be Blank!" unless params[:email].present?

            halt 500 unless user.update(
                name: params[:name],
                mobile: params[:mobile],
                email: params[:email]
            )

            status 201
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end
    
    #DELETE /api/v1/users/:id | Destroy
    delete '/users/:id' do
        begin
            user = User.find_by_id(params[:id])

            raise Exception, "User Not Found!" if user.nil?
            
            halt 500 unless user.destroy

            status 201
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end

end