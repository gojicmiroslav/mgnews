FactoryGirl.define do
  	factory :user do
  		sequence(:email){ |n| "email#{n}@email.com" }
  		password "password777"

	  	factory :user_regular do
		  	transient do
		      roles_count 1
		    end

		    after(:create) do |user, evaluator|
		      create_list(:regular, evaluator.roles_count, users: [user])
		    end
		end

	  	factory :user_editor do
		  	transient do
		      roles_count 1
		    end

		    after(:create) do |user, evaluator|
		      create_list(:editor, evaluator.roles_count, users: [user])
		    end
		end
  	end
end
