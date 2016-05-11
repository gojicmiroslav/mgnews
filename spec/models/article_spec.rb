require 'rails_helper'

RSpec.describe Article, type: :model do
  
  describe "validations" do
  	it { should validate_presence_of :title}
  	it { should validate_presence_of :body}

  	it 'belongs to user' do
			article = Article.new(title: "Some title", body: "Some body", 
														category: FactoryGirl.create(:category), user: nil)
			expect(article.valid?).to be_falsy
		end

		it 'belongs to user' do
			article = Article.new(title: "Some title", body: "Some body", 
														category: nil, user: FactoryGirl.create(:user))
			expect(article.valid?).to be_falsy
		end

		it 'has belongs_to user and belongs_to category association' do
			user = FactoryGirl.create(:user)
			category = FactoryGirl.create(:category)
			article = FactoryGirl.create(:article, user: user, category: category)
			expect(article.user).to eq(user)
			expect(article.category).to eq(category)
		end
  end
end
