require 'rails_helper'

RSpec.describe User, type: :model do

	describe "validations" do

		it 'has has_and_belongs_to_many roles association' do
			role1 = FactoryGirl.create(:regular)
			role2 = FactoryGirl.create(:editor)
			user = FactoryGirl.create(:user)
			user.roles << role1
			user.roles << role2
			user.save
			expect(user.roles).to match([role1, role2])
		end

		it 'has a Regular default role' do
			role = FactoryGirl.create(:regular)
			user = FactoryGirl.create(:user)
			expect(user.roles).to match([role])
		end

		it 'does not have Editor default role' do
			role = FactoryGirl.create(:editor)
			user = FactoryGirl.create(:user)
			expect(user.roles).not_to include(role)
		end
	end

end
