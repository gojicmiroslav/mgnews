require 'rails_helper'

describe ArticlesController do

	describe "GUEST USER" do
		let(:category){ FactoryGirl.create(:category) } 
		let(:role){ FactoryGirl.create(:regular) }
		let(:user){ FactoryGirl.create(:user_regular) }

		describe "GET index" do
			it "redirects to root url" do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "GET show" do
			let(:article){ FactoryGirl.create(:article, user: user, category: category) }

			it "redirects to root url" do
				get :show, id: article
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "GET new" do
			it "redirects to login page" do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "POST create" do
			it "redirects to root url" do
				post :create, article: FactoryGirl.attributes_for(:article, user: user, category: category)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe "GET edit" do
			it "redirects to root url" do
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

	describe "REGULAR USER" do
		let(:user){ FactoryGirl.create(:user_regular) }
		let(:category){ FactoryGirl.create(:category) } 
		let(:article) { FactoryGirl.create(:article, user: user, category: category) }

		before do
			sign_in(user)
		end

		describe "GET index" do
			it "redirects to root url" do
				get :index 
				expect(response).to redirect_to(root_url)
			end
		end

		describe "GET show" do
			let(:article){ FactoryGirl.create(:article, user: user, category: category) }

			it "redirects to root url" do
				get :show, id: article
				expect(response).to redirect_to(root_url)
			end
		end

		describe "GET new" do
			it "redirects to root url" do
				get :new
				expect(response).to redirect_to(root_url)
			end
		end

		describe "POST create" do
			it "redirects to root url" do
				post :create, article: FactoryGirl.attributes_for(:article, user: user, category: category)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "GET edit" do
			it "redirects to root url" do
				get :edit, id: FactoryGirl.create(:article, user: user, category: category)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "PUT update" do
			it "redirects to root url" do
				put :update, id: FactoryGirl.create(:article, user: user, category: category), 
											article: FactoryGirl.attributes_for(:article, user: user, category: category)
				expect(response).to redirect_to(root_url)
			end
		end

		describe "DELETE destroy" do
			it "redirects to root url" do
				delete :destroy, id: FactoryGirl.create(:article, user: user, category: category)
				expect(response).to redirect_to(root_url)
			end

			it "not deleted articles from database" do
					article = FactoryGirl.create(:article, user: user, category: category)
					expect{
						delete :destroy, id: article
					}.not_to change(Article, :count)
				end
		end
	end

	describe "EDITOR" do
		let(:user){ FactoryGirl.create(:user_editor) }
		let(:category){ FactoryGirl.create(:category) } 

		before do
			# sign_in users(:alice), scope: :admin
			sign_in user
		end

		describe "GET index" do
			it "renders :index template" do				
				get :index
				expect(response).to render_template(:index)
			end

			it "assings all articles of this editor to template" do
				other_user = FactoryGirl.create(:user, role: editor)
				published_article = FactoryGirl.create(:published_article, user: user, category: category)
				not_published_article = FactoryGirl.create(:not_published_article, user: user, category: category)
				other_published_article = FactoryGirl.create(:published_article, user: other_user, category: category)

				get :index 
				expect(assigns(:articles)).to match([published_article, not_published_article])
			end
		end

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
				let(:invalid_data){ FactoryGirl.attributes_for(:article, title: "", category: category) }

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

		context "is not owner of the article" do
			let(:another_user){ FactoryGirl.create(:user, role: editor) }

			describe "GET show" do
				let(:article){ FactoryGirl.create(:article, user: another_user, category: category) }

				it "redirects to root url" do
					get :show, id: article
					expect(response).to redirect_to(root_url)
				end
			end

			describe "GET edit" do
				it "redirects to root url" do
					get :edit, id: FactoryGirl.create(:article, user: another_user, category: category)
					expect(response).to redirect_to(root_url)
				end
			end

			describe "PUT update" do
				it "redirects to root url" do
					put :update, id: FactoryGirl.create(:article, user: another_user, category: category), 
											 article: FactoryGirl.attributes_for(:article, user: another_user, category: category)
					expect(response).to redirect_to(root_url)
				end
			end

			describe "DELETE destroy" do
				it "redirects to root url" do
					delete :destroy, id: FactoryGirl.create(:article, user: another_user, category: category)
					expect(response).to redirect_to(root_url)
				end

				it "not deleted articles from database" do
					article = FactoryGirl.create(:article, user: another_user, category: category)
					expect{
						delete :destroy, id: article
					}.not_to change(Article, :count)
				end
			end
		end

		context "is owner of the article" do
			let(:article){ FactoryGirl.create(:article, category: category, user: user) }

			describe "GET show" do
				describe "GET show" do
					it "renders :show template" do
						get :show, id: article
						expect(response).to render_template(:show)
					end

					it "assigns requested article to template" do
						get :show, id: article
						expect(assigns(:article)).to eq(article) 
					end
				end
			end

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

				context "article is published" do
					let!(:published_article) { FactoryGirl.create(:published_article, category: category, user: user) }

					it "not deletes article from the database" do
						expect{
							delete :destroy, id: published_article
						}.not_to change(Article, :count)
					end
				end

				context "article is not published" do
					let!(:not_published_article) { FactoryGirl.create(:not_published_article, category: category, user: user) }

					it "deletes article from the database" do
						delete :destroy, id: not_published_article
						expect(Article.where(id: not_published_article.id).exists?).to be_falsy
					end

					it "changes article count in the database" do
						expect{
							delete :destroy, id: not_published_article
						}.to change(Article, :count)
					end
				end
			end
		end
	end

end