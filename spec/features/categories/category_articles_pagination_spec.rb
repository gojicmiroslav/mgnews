require 'rails_helper'

feature 'Category articles pagination' do
	let!(:user){ FactoryGirl.create(:user_editor) }
	let!(:category){ FactoryGirl.create(:category) }


	context "should paginate" do
		before do
			#create articles
			20.times do
				FactoryGirl.create(:random_article, category: category, user: user)
			end
		end

		scenario 'should paginate articles' do
			visit category_path(category)

			expect(page).to have_css('nav.pagination')
		end
	end

	context "should not paginate" do
		before do
			#create articles
			5.times do
				FactoryGirl.create(:random_article, category: category, user: user)
			end
		end

		scenario 'should paginate articles' do
			visit category_path(category)

			expect(page).not_to have_css('nav.pagination')
		end
	end
end