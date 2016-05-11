class NewArticleForm
	include Capybara::DSL

	def visit_page
		visit('/articles')
		click_on('New Article')
		self
	end

	def fill_in_with(params = {})
		fill_in("Title", with: params.fetch(:title, "Default Article Title"))
		fill_in("Body", with: params.fetch(:body, "Default Article Body"))
		select('Default Category', from: 'Category')
		self
	end

	def submit
		click_on('Create Article')
		self
	end
end