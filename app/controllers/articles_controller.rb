class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :authorize_articles, only: :index

	def index
		@articles = get_all_articles_from_owner
	end

	def show
		authorize @article
	end

	def new
		@article = Article.new
		authorize @article
	end

	def create
		@article = current_user.articles.build(article_params)
		authorize @article

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
		redirect_to articles_path
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
    redirect_to(root_url)
	end

	def get_all_articles_from_owner
		@articles = []
		Article.all.each do |article|
			if current_user == article.user
				@articles << article
			end
		end
		@articles
	end

	def authorize_articles
		if !current_user.role.role.eql?("Editor")
			redirect_to root_url
		end
	end
end