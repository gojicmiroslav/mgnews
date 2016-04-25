require 'rails_helper'

feature 'Home Page' do

 scenario 'News Site title' do
 	visit('/')
 	expect(page).to have_content('MGNews')
 end

end