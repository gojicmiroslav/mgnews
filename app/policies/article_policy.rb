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
		puts "Size: " + article.user.roles.count.to_s
		puts "ROLES: #{article.user.roles}"

		if article.user.roles.nil?
			puts "NIL"
		else
			puts "NOT NIL"
			article.user.roles.each do |role|
				puts role.role
			end
		end		

		puts "Article user: #{article.user}"
		res = article.user.roles.include?(Role.where(role: "Editor").first)
		puts "Reponse: #{res}"
		res
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
		 is_editor? and is_owner?
	end

	private

	def is_editor?
		#@user.role.role.eql?("Editor")
		#@user.roles.include?(Role.where(role: "Editor").first)
		#@article.user.roles.include?(Role.where(role: "Editor").first)

		article.user.roles.each do |role|
			puts role.role
		end

		puts "Article user: #{article.user}"
		res = article.user.roles.include?(Role.where(role: "Editor").first)
		puts "Reponse: #{res}"
		res
	end

	def is_owner?
		@user == @article.user
	end
end