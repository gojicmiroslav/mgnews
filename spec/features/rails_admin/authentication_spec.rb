require 'rails_helper'

feature 'Rails Admin Authentication' do

	let(:admin){ FactoryGirl.create(:admin) }

	scenario "successfull login" do
		login_as(admin, :scope => :admin)
		visit("/admin")
		expect(page).to have_content("Site Administration")
		expect(page).not_to have_content("Log in")
	end

	scenario "unsuccessfull login" do
		visit("/admin")
		expect(page).not_to have_content("Site Administration")
		expect(page).to have_content("Log in")
	end	

end