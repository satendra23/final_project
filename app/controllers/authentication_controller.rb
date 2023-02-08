
class AuthenticationController < ApplicationController
    before_action :authorize_request, except: :login
  protect_from_forgery with: :null_session
    # POST /auth/login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        name=@user.name
        # render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
        respond_to do |format|
          format.json  { render :json => {:name => name, 
                                          :token_info => { token: token, exp: time.strftime("%m-%d-%Y %H:%M")}}}
        end
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
  end
