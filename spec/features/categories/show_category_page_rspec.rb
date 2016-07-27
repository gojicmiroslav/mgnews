require 'rails_helper'

describe 'Show Category' do
	let(:category){ FactoryGirl.create(:category) }
	let!(:category2){ FactoryGirl.create(:second_category) }
	let!(:user){ FactoryGirl.create(:user_editor) }
	let!(:first_article){ FactoryGirl.create(:article, user: user, category: category) }
	let!(:second_article){ FactoryGirl.create(:article, user: user, category: category2) }

	scenario "show category info" do
		visit category_path(category)
		expect(page).to have_content(category.name)
	end

	scenario "shows only articles for this category" do
		visit category_path(category)
		expect(page).to have_content(first_article.title)
		expect(page).not_to have_content(second_article.title)
	end

end