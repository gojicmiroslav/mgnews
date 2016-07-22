require 'rails_helper'

feature 'Show Article page' do
	let(:user){ FactoryGirl.create(:user_editor) }
	let!(:article) { FactoryGirl.create(:article, user: user, category: FactoryGirl.create(:category)) }

	scenario "shows article" do
		visit root_url
		expect(page).to have_content(article.title)
		expect(page).to have_content(article.show_text)
		click_link(article.title, match: :first)
		expect(page).to have_content(article.title)
		expect(page).to have_content(article.body)
	end

end