FactoryGirl.define do
  factory :user do
  	sequence(:email){ |n| "email#{n}@email.com" }
  	password "password777"
  end
end
