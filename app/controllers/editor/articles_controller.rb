class Editor::ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :authorize_articles, only: [:index]

	def index
		user_articles = get_all_articles_from_owner
		#@articles = Article.page params[:page]
		@articles = Kaminari.paginate_array(user_articles).page params[:page]
	end

	def show
		authorize @article
	end

	def new
		@article = Article.new(user: current_user)
		authorize @article
	end

	def create
		@article = current_user.articles.build(article_params)
		authorize @article

		if @article.save
			redirect_to editor_article_path(@article), notice: 'Article has been created'
		else
			render :new
		end
	end

	def edit
		authorize @article
	end

	def update
		authorize @article
		res = true

		if request.xhr? # if is AJAX
			@article.pubdate = params[:pubdate].nil? ? @article.pubdate : params[:pubdate]
			res = @article.save
		else
			res = @article.update(article_params)
		end

		if res
			respond_to do |format|
				format.html { redirect_to editor_article_path(@article), notice: 'Article was successfully updated.' } 
				format.js {}
			end		
		else
			respond_to do |format|
				format.html { render :edit }
				format.js {}
			end		 	
		end
	end

	def destroy
		authorize @article
		@article.destroy
		redirect_to editor_articles_path
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body, :pubdate, :featured_image, :user, :category, :show_text)
	end

	def user_not_authorized
		flash[:alert] = "You are not authorized to perform this action."
    	redirect_to(root_url)
	end

	def get_all_articles_from_owner
		@articles = []
		Article.publish_date_desc.each do |article|
			if current_user == article.user
				@articles << article
			end
		end
		@articles
	end

	def authorize_articles
		if !current_user.roles.include?(Role.where(role: "Editor").first)
			redirect_to root_url
		end
	end
end