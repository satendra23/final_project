class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :require_login, only:[:destroy]
    def new
    end
  
    def create
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to @user
      else  
        redirect_to login_path
      end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path      
    end
end
