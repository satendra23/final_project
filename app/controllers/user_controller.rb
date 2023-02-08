class UserController < ApplicationController
    layout false
    skip_before_action :verify_authenticity_token
    before_action :authorize_request, except: [:create, :show]
#   before_action :find_user, except: :create

    # before_action :userized, only: [:show]
    def show
        render json:User.all, status: :ok
    end

    def authart
        author=User.find_by(id: params[:id]);
        if(author==nil)
         render json: "User not found"
         else
          render json: author.articles
         end     
    end

    def new

    end

    def create
        @user=User.new(user_params)        
        if  @user.save
        render json: @user, status: :created
        else
            render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
        # redirect_to :controller => 'article', :action => 'create'
        end       
    end



    def find
        @user=User.find_by(params[:id]);
        if(user!=nil)
        render json:@user
        else
        render html: 'user not found'
        end
    end
    

    # PUT /users/{id}
    def edit
        unless @user.update(edit_user)
            render json: { errors: @user.errors.full_messages },
                   status: :unprocessable_entity
        end
   
        
    end

    def delete
        @user.destroy
        # user=User.find_by(params[:id])
        # if(user!=nil)
        # user.destroy
        # else
        # render html: 'User not deleted'  
        # end  
    end

    private
    def set_user
        @user=User.find(params[:id])
    end

    def user_params
        params.permit(:name, :email, :password, :description)
    end
    def edit_user
        params.permit(:description, :password)
    end
  
        
  end
