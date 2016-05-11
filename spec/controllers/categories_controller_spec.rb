require 'rails_helper'

describe CategoriesController do

	describe "GET index" do
		it "renders :index template" do
			get :index
			expect(response).to render_template(:index)
		end

		it "assings all categories to template" do
			category = FactoryGirl.create(:category)
			get :index 
			expect(assigns(:categories)).to match([category])
		end
	end

	describe "GET new" do
		it "renders template :new" do
			get :new
			expect(response).to render_template(:new)
		end

		it "assigns new Category to template" do
			get :new
			expect(assigns(:category)).to be_a_new(Category)
		end
	end

	describe "GET show" do
		let(:category){ FactoryGirl.create(:category) }

		it "renders template :show" do
			get :show, id: category
			expect(response).to render_template(:show)
		end

		it "assigns requested category to template" do
			get :show, id: category
			expect(assigns(:category)).to eq(category)
		end
	end

	describe "POST create" do
		context "valid data" do
			let(:valid_data){ FactoryGirl.attributes_for(:category) }
			
			it "redirect to category#show page" do
				post :create, category: valid_data
				expect(response).to redirect_to(category_path(assigns(:category)))
			end
			
			it "creates new category in database"	do
				expect {
					post :create, category: valid_data
				}.to change(Category, :count).by(1)
			end
		end

		context "invalid data" do
			let(:invalid_data) { FactoryGirl.attributes_for(:category, name: '') }

			it "renders :new template" do
				post :create, category: invalid_data
				expect(response).to render_template :new
			end
			
			it "doesn't create new category in the database" do
				expect {
					post :create, category: invalid_data
				}.not_to change(Category, :count)
			end
		end
	end

	describe "GET edit" do
		let(:category) { FactoryGirl.create(:category) }

		it "renders :edit template" do
			get :edit, id: category
			expect(response).to render_template(:edit)
		end

		it "assigns the requested category to template" do
			get :edit, id: category
			expect(assigns(:category)).to eq(category)
		end
	end

	describe "PUT update" do
		let(:category){ FactoryGirl.create(:category) }

		context "valid data" do
			let(:valid_data){ FactoryGirl.attributes_for(:category, name: "New Name") }

			it "redirects to category#show page" do
				put :update, id: category, category: valid_data
				expect(response).to redirect_to(category_path(category))
			end

			it "updates category in the database" do
				put :update, id: category, category: valid_data
				category.reload
				expect(category.name).to eq("New Name")
			end
		end

		context "invalid data" do
			let(:invalid_data){ FactoryGirl.attributes_for(:category, name: "") }

			it "renders :edit template" do
				put :update, id: category, category: invalid_data
				expect(response).to render_template(:edit)
			end

			it "doesn't update category in the database" do
				put :update, id: category, category: invalid_data
				category.reload
				expect(category.name).not_to eq("")
			end
		end
	end

	describe "DELETE destroy" do
		let(:category){ FactoryGirl.create(:category) }

		it "redirects to category#index" do
			delete :destroy, id: category
			expect(response).to redirect_to(categories_path)
		end

		it "deletes category from the database" do
			delete :destroy, id: category
			expect(Category.where(id: category.id).exists?).to be_falsy
		end
	end

end