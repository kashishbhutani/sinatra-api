namespace '/api/v1' do

    get '/posts' do
        Post.all.to_json
    end
    
    get '/posts/:id' do
        begin
            post = Post.find_by_id(params[:id])
        
            raise Exception, "Post Not Found!" if post.nil?
            
            post.to_json
        rescue Exception => e
            status 404
			e.message.to_json
		end
    end
    
    post '/posts' do
        begin
            raise Exception, "Title Can't Be Blank!" unless params[:title].present?

            raise Exception, "Description Can't Be Blank!" unless params[:description].present?
            
            halt 500 unless Post.create(
                title: params[:title],
                description: params[:description]
            )
    
            status 201
        rescue Exception => e
            status 404
			e.message.to_json
		end
    end

    put 'posts/:id' do
        begin
            post = Post.find_by_id(params[:id])
      
            raise Exception, "Post Not Found!" if post.nil?

            halt 500 unless post.update(
                title: params[:title],
                description: params[:description]
            )

            status 201
        rescue Exception => e
			e.message.to_json
		end
    end
    
    delete '/posts/:id' do
        begin
            post = Post.find_by_id(params[:id])

            raise Exception, "Post Not Found!" if post.nil?
            
            halt 500 unless post.destroy
        rescue Exception => e
            status 404
			e.message.to_json
		end
    end

end