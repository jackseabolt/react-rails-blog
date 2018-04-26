class PostsController < ApplicationController
    # controls error handling 
    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index 
        @posts = Post.all
        render json: @posts, include: 'comments', status: 200
    end 

    def create 
        @post = Post.new(post_params)
        if @post.save
            render json: @post, status: 201
        else 
            render json: {status: "error", code: 400, message: "Not all required params were provided"}, status: 400
        end
    end 

    def destroy 
        @post = Post.find(params[:id])
        if @post.destroy 
            respond_to do |format|
                format.json { head :no_content }
            end 
        end
    end
    
    private 

        # defines the data in the post model
        def post_params
            params.permit(:content, :title)
        end 
    
        # this doesn't work right now, but it supposedly is triggered when validation errors occur
        # def render_unprocessable_entity_response(exception)
        #   render json: exception.record.errors, status: :unprocessable_entity
        # end
    
        # this will be sent if destroy or update request is made without existing id
        def render_not_found_response(exception)
        render json: {
            message: "Validation Failed",
            errors: exception.message, 
            location: 'id'
        }, status: 422
        end
end