require 'rails_helper'

describe ArticlesController do

	shared_examples "public access to articles" do
		describe "GET index" do
			it "renders :index template" do
				get :index
				expect(response).to render_template(:index)
			end

			it "assings all articles to template" do
				article = FactoryGirl.create(:article, user: user, category: category)
				get :index 
				expect(assigns(:articles)).to match([article])
			end
		end

		describe "GET show" do
			let(:article){ FactoryGirl.create(:article, user: user, category: category) }

			it "renders template :show" do
				get :show, id: article
				expect(response).to render_template(:show)
			end

			it "assigns requested article to template" do
				get :show, id: article
				expect(assigns(:article)).to eq(article)
			end
		end
	end

	describe "GUEST USER" do
		let(:user){ FactoryGirl.create(:user) }
		let(:category){ FactoryGirl.create(:category) } 

		it_behaves_like "public access to articles"

		describe "GET new" do
			it "redirects to login page" do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "POST create" do
			it "redirects to login page" do
				post :create, article: FactoryGirl.attributes_for(:article, user: user, category: category)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "GET edit" do
			it "redirects to login page" do
				get :edit, id: FactoryGirl.create(:article, user: user, category: category)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "PUT update" do
			it "redirects to login page" do
				put :update, id: FactoryGirl.create(:article, user: user, category: category), 
											article: FactoryGirl.attributes_for(:article, user: user, category: category)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "DELETE destroy" do
			it "redirects to login page" do
				delete :destroy, id: FactoryGirl.create(:article, user: user, category: category)
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "AUTHENTICATED USER" do
		let(:user){ FactoryGirl.create(:user) }
		let(:category){ FactoryGirl.create(:category) } 

		before do
			sign_in(user)
		end

		it_behaves_like "public access to articles"

		describe "GET new" do
			it "renders template :new" do
				get :new
				expect(response).to render_template(:new)
			end

			it "assigns new article to template" do
				get :new
				expect(assigns(:article)).to be_a_new(Article)
			end
		end

		describe "POST create" do
			context "valid data" do
				let(:valid_data){ FactoryGirl.attributes_for(:article, category: category) }

				it "redirect to article#show page" do
					post :create, article: valid_data
					expect(response).to redirect_to(article_path(assigns(:article)))
				end

				it "creates new article in database"	do
					expect {
						post :create, article: valid_data
					}.to change(Article, :count).by(1)
				end
			end

			context "invalid data" do
				let(:invalid_data){ FactoryGirl.attributes_for(:article, title: "") }

				it "renders :new template" do
					post :create, article: invalid_data
					expect(response).to render_template :new
				end
				
				it "doesn't create new article in the database" do
					expect {
						post :create, article: invalid_data
					}.not_to change(Article, :count)
				end
			end
		end

		context "is not the owner of the article" do
			let(:another_user){ FactoryGirl.create(:user) }

			describe "GET edit" do
				it "redirects to articles page" do
					get :edit, id: FactoryGirl.create(:article, user: another_user, category: category)
					expect(response).to redirect_to(articles_path)
				end
			end

			describe "PUT update" do
				it "redirects to articles page" do
					put :update, id: FactoryGirl.create(:article, user: another_user, category: category), 
											 article: FactoryGirl.attributes_for(:article, user: another_user, category: category)
					expect(response).to redirect_to(articles_path)
				end
			end

			describe "DELETE destroy" do
				it "redirects to articles page" do
					delete :destroy, id: FactoryGirl.create(:article, user: another_user, category: category)
					expect(response).to redirect_to(articles_path)
				end

				it "not deleted articles from database" do
					article = FactoryGirl.create(:article, user: another_user, category: category)
					expect{
						delete :destroy, id: article
					}.not_to change(Article, :count)
				end
			end
		end

		context "is the owner of the article" do
			let(:article){ FactoryGirl.create(:article, user: user, category: category) }

			describe "GET edit" do
				it "renders :edit template" do
					get :edit, id: article
					expect(response).to render_template(:edit)
				end

				it "assigns the requested article to template" do
					get :edit, id: article
					expect(assigns(:article)).to eq(article)
				end
			end

			describe "PUT update" do
				context "valid data" do
					let(:valid_data){ FactoryGirl.attributes_for(:article, title: "New Article Title", user: user, category: category) }

					it "redirects to article#show page" do
						put :update, id: article, article: valid_data
						expect(response).to redirect_to article_path(article)
					end

					it "updates article in the database" do
						put :update, id: article, article: valid_data
						article.reload
						expect(article.title).to eq("New Article Title")
					end
				end

				context "invalid data" do
					let(:invalid_data){ FactoryGirl.attributes_for(:article, title: "", user: user, category: category) }

					it "renders :edit template" do
						put :update, id: article, article: invalid_data
						expect(response).to render_template(:edit)
					end

					it "doesn't update article in the database" do
						put :update, id: article, article: invalid_data
						article.reload
						expect(article.title).not_to eq("")
					end
				end
			end

			describe "DELETE destroy" do
				it "redirects to article#index" do
					delete :destroy, id: article
					expect(response).to redirect_to(articles_path)
				end

				it "deletes article from the database" do
					delete :destroy, id: article
					expect(Article.where(id: article.id).exists?).to be_falsy
				end
			end
		end
	end
end