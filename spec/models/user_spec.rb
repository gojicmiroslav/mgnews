require 'rails_helper'

RSpec.describe User, type: :model do

	describe "validations" do
  	it { should validate_presence_of :role}

  	it 'belongs to role' do
  		expect {
				user = User.create!(:user, role: nil)
			}.to raise_exception
		end

		it 'has belongs_to role association' do
			role = FactoryGirl.create(:regular)
			user = FactoryGirl.create(:user, role: role)
			expect(user.role).to eq(role)
		end
	end

end
