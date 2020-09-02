#Posts API(Version 1)

namespace '/api/v1' do

    #GET /api/v1/users/:user_id/posts | Index
    get '/users/:user_id/posts' do
        begin
            raise Exception, "User Not Found!" unless user = User.find_by_id(params[:user_id])

            raise Exception, "No Post Found For User Id - #{user&.id}!" unless user&.posts.present?

            user&.posts.to_json
        rescue Exception => e
            status 400
            e.message.to_json
        end
    end
    
    #GET /api/v1/users/:user_id/posts/:id | Show
    get '/users/:user_id/posts/:id' do
        begin
            raise Exception, "User Not Found!" unless user = User.find_by_id(params[:user_id])

            post = user.posts.where(id: params[:id]).last
        
            raise Exception, "Post Not Found!" unless post.present?
            
            post.to_json
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end
    
    #POST /api/v1/users/:user_id/posts | Create
    post '/users/:user_id/posts' do
        begin
            raise Exception, "User Not Found!" unless user = User.find_by_id(params[:user_id])

            raise Exception, "Title Can't Be Blank!" unless params[:title].present?

            raise Exception, "Description Can't Be Blank!" unless params[:description].present?

            halt 500 unless user.posts.create(
                title: params[:title],
                description: params[:description]
            )
    
            status 201
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end

    #PUT /api/v1/users/:user_id/posts/:id | Update
    put '/users/:user_id/posts/:id' do
        begin
            raise Exception, "User Not Found!" unless user = User.find_by_id(params[:user_id])

            post = user.posts.where(id: params[:id]).last
        
            raise Exception, "Post Not Found!" unless post.present?

            raise Exception, "Title Can't Be Blank!" unless params[:title].present?

            raise Exception, "Description Can't Be Blank!" unless params[:description].present?

            halt 500 unless post.update(
                title: params[:title],
                description: params[:description]
            )

            status 201
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end
    
    #DELETE /api/v1/users/:user_id/posts/:id | Destroy
    delete '/users/:user_id/posts/:id' do
        begin
            raise Exception, "User Not Found!" unless user = User.find_by_id(params[:user_id])

            post = user.posts.where(id: params[:id]).last
        
            raise Exception, "Post Not Found!" unless post.present?
            
            halt 500 unless post.destroy

            status 201
        rescue Exception => e
            status 400
			e.message.to_json
		end
    end

end