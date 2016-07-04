require 'rails_helper'

describe 'Show Category' do

	scenario "category page" do
		category = FactoryGirl.create(:category)
		visit category_path(category)
		expect(page).to have_content(category.name)
	end

end