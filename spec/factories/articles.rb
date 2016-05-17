FactoryGirl.define do
  factory :article do
    sequence(:title){ |n| "Article #{n}" }
    body "MyString"
    pubdate "2016-05-03 21:33:21"
    featured_image_url "some_file.png"

    factory :published_article do
    	published DateTime.now
    end

    factory :not_published_article do
    	published nil
    end
  end
end
