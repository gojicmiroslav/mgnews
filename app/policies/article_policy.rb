class ArticlePolicy < ApplicationPolicy
	attr_reader :user, :article

	def initialize(user, article)
		@user = user
		@article = article
	end

	# def index
	# 	is_editor?
	# end

	def show?
		is_editor? and is_owner?
	end

	def new?
		is_editor?
	end

	def create?
		is_editor?
	end

	def edit?
		is_editor? and is_owner?
	end

	def update?
		is_editor? and is_owner?
	end

	def destroy?
		 is_editor? and is_owner? and is_not_published?
	end

	private

	def is_editor?
		@user.role.role.eql?("Editor")
	end

	def is_owner?
		@user == @article.user
	end

	def is_not_published?
		@article.published == nil
	end
end