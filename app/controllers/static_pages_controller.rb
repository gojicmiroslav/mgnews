class StaticPagesController < ApplicationController

	def index
		@categories = Category.all
		@articles = Article.published
		@first_three_articles = Article.first_three_articles
		@second_two_articles = Article.second_two_articles
	end

	def article
		
	end

end