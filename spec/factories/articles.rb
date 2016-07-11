FactoryGirl.define do
  factory :article do
    sequence(:title){ |n| "Article #{n}" }
    show_text "Show text"
    body "MyString"
    pubdate "2016-05-03 21:33:21"
    featured_image "some_file.png"

    factory :published_article do
    	pubdate DateTime.now
    end

    factory :unpublished_article do
    	pubdate nil
    end
  end

  factory :first_article, parent: :article do
    title "First Article"
    pubdate 1.day.ago
  end 

  factory :second_article, parent: :article do
    title "Second Article"
    pubdate 2.day.ago
  end 

  factory :third_article, parent: :article do
    title "Third Article"
    pubdate 3.day.ago
  end 

  factory :fourth_article, parent: :article do
    title "Fourth Article"
    pubdate 4.day.ago
  end 

  factory :fifth_article, parent: :article do
    title "Fifth Article"
    pubdate 5.day.ago
  end 
end
