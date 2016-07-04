require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_presence_of :role}

  it 'has has_many users association' do
  	role = FactoryGirl.create(:regular)
		user1 = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		role.users << user1
		role.users << user2
		role.save
		expect(role.users).to match([user1, user2])
	end
end
