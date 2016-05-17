require 'rails_helper'

describe "Show Article" do
	let(:login_form){ LoginForm.new }
	let(:role){ FactoryGirl.create(:editor) }
	let(:user){ FactoryGirl.create(:user, role: role) }

	scenario "article page" do
		login_form.visit_page(new_user_session_path).login_as(user)
		article = FactoryGirl.create(:article, user: user, category: FactoryGirl.create(:category))
		visit article_path(article)
		expect(page).to have_content(article.title)
		expect(page).to have_content(article.body)
	end

end