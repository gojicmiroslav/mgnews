require 'rails_helper'

describe "Show Article" do
	let(:user){ FactoryGirl.create(:user_editor) }

	before do
		login_as(user, :scope => :user)
	end

	scenario "article page" do
		article = FactoryGirl.create(:article, user: user, category: FactoryGirl.create(:category))
		visit article_path(article)
		expect(page).to have_content(article.title)
		expect(page).to have_content(article.body)
	end

end