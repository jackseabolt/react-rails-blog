class PostsController < ApplicationController
    
    # controls error handling 
    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    # prevents csrf blocking
    protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }

    def index 
        @posts = Post.all
        render json: @posts, include: 'comments', status: 200
    end 

    def create 
        @post = Post.new(post_params)
        if @post.save
            render json: @post, status: 201
        else 
            render json: {
                status: 400, 
                message: "Required params were not provided",
            }, status: 400
        end
    end 

    def destroy 
        @post = Post.find(params[:id])
        if @post.destroy  
            render json: { 
                status: 202,
                message: 'Record removed',
            }, status: 202
        else 
            render json: {
                status: 400, 
                message: "There was a problem",
            }, status: 400
        end
    end
    
    private 

        # defines the data in the post model
        def post_params
            params.require(:post).permit(:content, :title)
        end 
    
        # this will be sent if destroy or update request is made without existing id
        def render_not_found_response(exception)
        render json: {
            message: "Validation Failed",
            errors: exception.message, 
            location: 'id'
        }, status: 422
        end

        # def render_unprocessable_entity_response(exception)
        #   render json: exception.record.errors, status: :unprocessable_entity
        # end
end