class ArticleController < ApplicationController
  skip_before_action :verify_authenticity_token
  # skip_before_action :require_login, only:[:create,:show] 
  before_action :authorize_request, except: [:login, :index, :show]
  def index
    @article=Article.all    
    render :json => @article, :include => {:categories => {:only => :name}}

  end
 

  def show
    # @article=Article.find(params[:id])
    # render json: @article
    if params[:id]
      @article = Article.find_by(id: params[:id])      
      render :json => @article, :include => {:categories => {:only => :name}}
  elsif params[:title]
      articles = Article.where("title LIKE ?", "%" + Article.sanitize_sql_like(params[:title]) + "%")
      render json: articles, :include => {:categories => {:only => :name}}
  elsif params[:category]
      # category = Category.where("name LIKE ?", "%" + Category.sanitize_sql_like(params[:category]) + "%")
      category = Category.find_by(name: params[:category])
      render json: category.articles
  
  # elsif params[:author_name]
  #     author = Author.find_by()

  else
      @articles = Article.all
      render json: @articles[0].categories
  end

  

  end

  def new
    @article=Article.new
    
  end

  def edit
    @article=Article.find(params[:id])
  end

  def create
    if @current_user == nil
        render json:{ errors: "User not authorized" }, status: :unauthorized
    else
        @article = @current_user.articles.create(title: params[:title], text: params[:text])

        for category_name in params[:categories]        
          @category=Category.find_by(name: category_name)   
            if @category == nil
              @category = Category.create(name: category_name)
            end
            @article.categories << @category 
        end
        render :json => @article, :include => {:categories => {:only => :name}}
    end
  end

  def update
    if @current_user == nil
      render json:{ errors: "User not authorized" }, status: :unauthorized
    else
      @article = Article.find(params[:id])
      if @article.update(params.require(:article).permit(:title, :text))
    #   lash[:notice] = "Article was updated successfully."
      render   json:@article
      else
        render 'edit'
      end
    end
  end
  
  def delete
    article=Article.find_by(id: params[:id])
    if(@current_user==nil)
    render html: "User not authorized"
    elsif(@current_user.id.to_i!=article.user_id.to_i)    
     render json: {error: "You are not authorized to delete this page"}
    else
     article.destroy
     render json: article
    end          
end   


end
