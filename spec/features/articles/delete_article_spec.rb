require 'rails_helper'
require_relative '../../support/login_form'

feature "Delete Article" do
	let(:login_form){ LoginForm.new }
	let(:role){ FactoryGirl.create(:editor) }
	let(:user){ FactoryGirl.create(:user, role: role) }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:article){ FactoryGirl.create(:article, category: category, user: user) }

	before do
		login_form.visit_page(new_user_session_path).login_as(user)
	end

	scenario "delete article" do
		visit articles_path
		expect {
			click_on("Delete")
		}.to change(Article, :count).by(-1)
	end
end
