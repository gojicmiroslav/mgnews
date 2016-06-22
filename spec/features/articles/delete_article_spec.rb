require 'rails_helper'

feature "Delete Article" do
	let!(:user){ FactoryGirl.create(:user_editor) }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:article){ FactoryGirl.create(:article, category: category, user: user) }

	before do
		login_as(user, :scope => :user)
	end

	scenario "delete article" do
		visit articles_path
		expect {
			click_on("Delete")
		}.to change(Article, :count).by(-1)
	end
end
