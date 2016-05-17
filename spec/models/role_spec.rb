require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_presence_of :role}

  it 'has has_many users association' do
  	role = FactoryGirl.create(:regular)
		user = FactoryGirl.create(:user, role: role)
		role.users << user
		role.save
		expect(role.users).to match([user])
	end
end
