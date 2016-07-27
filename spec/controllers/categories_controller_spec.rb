require 'rails_helper'

describe CategoriesController do
	let(:category){ FactoryGirl.create(:category) }
	
	describe "GET show" do	
		it "renders template :show" do
			get :show, id: category
			expect(response).to render_template(:show)
		end

		it "assigns requested category to template" do
			get :show, id: category
			expect(assigns(:category)).to eq(category)
		end
	end
end