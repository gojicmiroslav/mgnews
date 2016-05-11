require 'rails_helper'

describe "Show Article" do

	scenario "article page" do
		article = FactoryGirl.create(:article, user: FactoryGirl.create(:user), category: FactoryGirl.create(:category))
		visit article_path(article)
		expect(page).to have_content(article.title)
		expect(page).to have_content(article.body)
	end

end