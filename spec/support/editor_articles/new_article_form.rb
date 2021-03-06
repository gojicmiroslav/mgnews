class NewArticleForm
	include Capybara::DSL

	def visit_page
		visit('/editor/articles')
		click_on('New Article')
		self
	end

	def fill_in_with(params = {})
		fill_in("Title", with: params.fetch(:title, "New Article Title"))
		fill_in("Show Text", with: params.fetch(:show_text, "New Show Text"))
		fill_in("Body", with: params.fetch(:body, "New Article Body"))
		select('Default Category', from: 'Category')
		attach_file('Featured image', "#{Rails.root}/spec/fixtures/" + params.fetch(:featured_image, 'featured_image.png'))
		self
	end

	def submit
		click_on('Create Article')
		self
	end
end