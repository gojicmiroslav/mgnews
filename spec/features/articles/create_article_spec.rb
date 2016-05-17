require 'rails_helper'
require_relative '../../support/login_form'
require_relative '../../support/articles/new_article_form'

feature 'Create new article' do
	let(:login_form){ LoginForm.new }
	let(:new_article_from) { NewArticleForm.new }
	let(:role){ FactoryGirl.create(:editor) }
	let(:user){ FactoryGirl.create(:user, role: role) }
	let!(:category){ FactoryGirl.create(:category) }

	scenario "create new article with valid data" do
		login_form.visit_page(new_user_session_path).login_as(user)
		new_article_from.visit_page.fill_in_with(title: "New Article", body: "Article Body").submit

		expect(page).to have_content("Article has been created")
		expect(Article.last.title).to eq("New Article")
	end

	scenario "cannot create article with invalid data" do
		login_form.visit_page(new_user_session_path).login_as(user)
		new_article_from.visit_page.submit

		expect(page).to have_content("can't be blank")
	end

end