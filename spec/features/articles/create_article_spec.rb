require 'rails_helper'
require_relative '../../support/articles/new_article_form'

feature 'Create new article' do
	let(:new_article_form) { NewArticleForm.new }
	let!(:user){ FactoryGirl.create(:user_editor) }
	let!(:category){ FactoryGirl.create(:category) }

	before do
		login_as(user, :scope => :user)
	end

	scenario "create new article with valid data" do
		new_article_form.visit_page.fill_in_with(title: "New Article", body: "Article Body", 
																						 show_text: "New Show Text").submit

		expect(page).to have_content("Article has been created")
		expect(Article.last.title).to eq("New Article")
	end

	scenario "cannot create article with invalid data" do
		new_article_form.visit_page.submit

		expect(page).to have_content("can't be blank")
	end

end