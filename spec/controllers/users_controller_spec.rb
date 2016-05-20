require 'rails_helper'

describe RegistrationsController do

	before :each do
  	request.env['devise.mapping'] = Devise.mappings[:user]
	end

	it "assings Regular default role for new user" do 
		role = FactoryGirl.create(:regular)
		post :create, user: FactoryGirl.build(:user, password_confirmation: "password777")
		expect(assigns(:user).role).to eq(role)
	end

end