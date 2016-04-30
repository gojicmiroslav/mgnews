require 'rails_helper'
require_relative '../../support/new_category_form'

describe 'Create New Category' do

	scenario "create new category with valid data" do
		new_category_form = NewCategoryForm.new
		new_category_form.visit_page.fill_in_with(name: "First Category").submit

		expect(page).to have_content('Category has been created')
		expect(Category.last.name).to eq('First category')
	end

	scenario "cannot create category with invalid data" do
		visit('/categories')
		click_on('New Category')
		click_on('Create Category')
		expect(page).to have_content("can't be blank")		
	end

end