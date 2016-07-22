require 'rails_helper'

feature 'Article index' do
	let(:user){ FactoryGirl.create(:user_editor) }
	let(:user2){ FactoryGirl.create(:user_editor) }
	let(:category){ FactoryGirl.create(:category) }
	let!(:article1) { FactoryGirl.create(:article, category: category, user: user) }
	let!(:article2) { FactoryGirl.create(:article, category: category, user: user2) }

	before do
		login_as(user, :scope => :user)
	end

	# TODO
	scenario "shows articles ordered by :created_at in :desc order" do
		visit editor_articles_path
	end

	scenario "shows only articles of current authenticated user" do
		visit editor_articles_path

		expect(page).to have_content(article1.title)
		expect(page).not_to have_content(article2.title)
	end

end