class ApplicationController < ActionController::Base
    # prevents csrf blocking
    protect_from_forgery with: :null_session
end



