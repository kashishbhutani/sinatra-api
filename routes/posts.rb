namespace '/api/v1' do

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