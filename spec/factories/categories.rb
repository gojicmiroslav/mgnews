FactoryGirl.define do

	factory :category do
		name "Default Category"
		menu_order 1
	end

	factory :second_category, parent: :category do
		name "Second Category"
		menu_order 2
	end

end