require 'rails_helper'

RSpec.describe Article, type: :model do
  
  describe "validations" do
  	it { should validate_presence_of :title}
  	it { should validate_presence_of :show_text}
  	it { should validate_presence_of :body}
  	it { should validate_length_of(:show_text).is_at_most(250) }

  	it 'belongs to user' do
  		expect {
				FactoryGirl.create(:article, category: FactoryGirl.create(:category))
			}.to raise_error
		end

		it 'belongs to category' do
			expect {
				FactoryGirl.create(:article, user: FactoryGirl.create(:user_editor))
			}.to raise_error
		end

		it 'has belongs_to user and belongs_to category association' do
			user = FactoryGirl.create(:user_regular) 
			category = FactoryGirl.create(:category)  
			article = FactoryGirl.create(:article, user: user, category: category) 
			expect(article.user).to eq(user)
			expect(article.category).to eq(category)
		end
  end

  describe 'scopes' do
  	it "should return only published articles" do
  		user = FactoryGirl.create(:user_editor)
  		category = FactoryGirl.create(:category)
  		published_article = FactoryGirl.create(:published_article, user: user, category: category)
  		unpublished_article = FactoryGirl.create(:unpublished_article, user: user, category: category)

  		expect(Article.published).to match([published_article])
  	end
  end
end
