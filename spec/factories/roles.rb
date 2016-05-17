FactoryGirl.define do
  factory :role do
    role "Default"
  end

  factory :regular, parent: :role do
    role "Regular"
  end

  factory :editor, parent: :role do
    role "Editor"
  end
end
