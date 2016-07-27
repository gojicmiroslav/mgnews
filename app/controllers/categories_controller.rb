class CategoriesController < ApplicationController

	def show
		@category = Category.find(params[:id])
		@articles = Article.category_articles(@category).page params[:page]
	end
end