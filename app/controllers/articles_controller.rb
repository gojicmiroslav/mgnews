class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def index
		@articles = Article.all
	end

	def show
	end

	def new
		@article = Article.new
	end

	def create
		#@article = Article.new(article_params)
		@article = current_user.articles.build(article_params)

		if @article.save
			redirect_to @article, notice: 'Article has been created'
		else
			render :new
		end
	end

	def edit
		authorize @article
	end

	def update
		authorize @article
		if @article.update(article_params)
			redirect_to @article, notice: 'Article was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		authorize @article
		@article.destroy
		redirect_to articles_url
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body, :pubdate, :featured_image_url, :user, :category)
	end

	def user_not_authorized
		flash[:alert] = "You are not authorized to perform this action."
    redirect_to(articles_path)
	end
end