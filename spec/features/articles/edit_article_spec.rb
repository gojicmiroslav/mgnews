require 'rails_helper'
require_relative '../../support/login_form'
require_relative '../../support/articles/edit_article_form'

feature "Edit Article" do
	let(:login_form){ LoginForm.new }
	let(:role){ FactoryGirl.create(:editor) }
	let(:user){ FactoryGirl.create(:user, role: role) }
	let(:edit_article_from) { EditArticleForm.new }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:article){ FactoryGirl.create(:article, category: category, user: user) }

	before do
		login_form.visit_page(new_user_session_path).login_as(user)
	end

	scenario "edit article with valid data" do
		edit_article_from.visit_page(article.id).fill_in_with(title: "Updated Article", body: "Updated Body").submit

		expect(page).to have_content("Article was successfully updated.")
		expect(Article.last.title).to eq("Updated Article")
	end

	scenario "can't edit article with invalid data" do
		edit_article_from.visit_page(article.id).fill_in_with(title: "", body: "Updated Body").submit
		expect(page).to have_content("can't be blank")
	end

end