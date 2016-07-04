class NewCategoryForm
	include Capybara::DSL

	def visit_page
		visit('/categories')
		click_on('New Category')
		self
	end

	def fill_in_with(params = {})
		fill_in('Name', with: params.fetch(:name, 'Default Category'))
		select('1', from: 'Menu Order')
		self
	end

	def submit
		click_on('Create Category')
		self
	end

end