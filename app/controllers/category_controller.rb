class CategoryController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        @category=Category.create(name: params[:name]);
    end
    def show
        @category=Category.all;
        render json: @category
    end

    def delete
        @category=Category.find_by(params[:id])
        if(@category!=nil)
            @category.destroy
        else
        render html: "Nothing to delete"
        end
    end   

    # def find
    #     category=Category.where(name:params[:name])
    #     @pcategories.each do |@category|
    #     id=c@ategory.ids
    #     x=ArticleCategory.where(category_id:id)
    #     @allart=Article.find(x.article_id)
    #     render json: @allart
    #     end
    # end

  
    
end
