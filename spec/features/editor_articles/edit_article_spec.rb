require 'rails_helper'
require_relative '../../support/editor_articles/edit_article_form'

feature "Edit Article" do
	let!(:user){ FactoryGirl.create(:user_editor) }
	let(:edit_article_from) { EditArticleForm.new }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:article){ FactoryGirl.create(:article, category: category, user: user) }

	before do
		login_as(user, :scope => :user)
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