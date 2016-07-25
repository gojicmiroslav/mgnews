require 'rails_helper'

feature 'Home Page' do

 	scenario 'News Site title' do
 		visit('/')
 		expect(page).to have_content('MGNews')
 	end

 	context 'Published articles' do
 		let(:user){ FactoryGirl.create(:user_editor) }
 		let(:category){ FactoryGirl.create(:category) }
		let!(:published_article) { FactoryGirl.create(:published_article, category: category, user: user) }
		let!(:unpublished_article) { FactoryGirl.create(:unpublished_article, category: category, user: user) }

		scenario "shows only published articles" do
			visit root_url
			expect(page).to have_content(published_article.title)
			expect(page).not_to have_content(unpublished_article.title)
		end
	end

	# scenario 'shows latest for article in category panel' do
	# 	role = FactoryGirl.create(:regular) 
	# user = FactoryGirl.create(:user_regular) 
	# 	category = FactoryGirl.create(:category)
	# 	first_article = FactoryGirl.create(:first_article, user: user, category: category)
	# 	second_article = FactoryGirl.create(:second_article, user: user, category: category)
	# 	third_article = FactoryGirl.create(:third_article, user: user, category: category)
	# 	fourth_article = FactoryGirl.create(:fourth_article, user: user, category: category)
	# 	fifth_article = FactoryGirl.create(:fifth_article, user: user, category: category)
	# 	visit('/')
		
	# 	expect(page).to have_css("h3.panel-title", category.name)
	# 	expect(page).to have_css("div.panel-body a", first_article.title)
	# 	expect(page).not_to have_css("div.panel-body a", fifth_article.title)
	# end

	scenario "header should display Sign In link if user not logged in" do
		visit('/')
		expect(page).to have_link("Sign In", href: new_user_session_path)
	end

	scenario "header should display user email if user logged in" do
		user = FactoryGirl.create(:user_regular)
		login_as(user, :scope => :user)
		
		visit('/')
		expect(page).to have_link(user.email, href: edit_user_registration_path)
		expect(page).not_to have_link("Sign In", href: new_user_session_path)
	end
end