class EditArticleForm
	include Capybara::DSL

	def visit_page(id)
		visit("/editor/articles/#{id}/edit")
		self
	end

	def fill_in_with(params = {})
		fill_in("Title", with: params.fetch(:title, "Updated Article Title"))
		fill_in("Body", with: params.fetch(:body, "Updated Article Body"))
		select('Default Category', from: 'Category')
		self
	end

	def submit
		click_on('Update Article')
		self
	end
end