require "rails_helper"

feature 'Publish Article', js: true do
	let!(:user){ FactoryGirl.create(:user_editor) }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:article){ FactoryGirl.create(:unpublished_article, user: user, category: category) }

	before do
		login_as(user, :scope => :user)
	end

	scenario "should publish article" do
		# visit editor_articles_path
		# expect(page).to have_content('Unpublished')
		# click_on('Publish')
		# expect(page).to have_content('Published')
	end

end