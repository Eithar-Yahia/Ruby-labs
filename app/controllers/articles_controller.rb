class ArticlesController < ApplicationController

  #before_action :authenticate_user!
  #load_and_authorize_resource :only => [:index]

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def index
        @articles = Article.all
        respond_to do |format|
            format.html
            format.json {render json: @articles}
        end
    end
    def show
        @article = Article.find(params[:id])
        respond_to do |format|
            format.html
            format.json {render json: @article}
        end
    end

    def create
        @article =current_user.articles.build(article_params)
        #@article =Article.new(article_params)

        if @article.save
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        @article = Article.find(params[:id])
       
        if @article.update(article_params.merge(user_id: current_user.id))
          redirect_to @article
        else
          render 'edit'
        end
    end
        
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
   
        redirect_to articles_path
    end
    private
        def article_params
            params.require(:article).permit(:title, :text )
        end
end
