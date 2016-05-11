class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String
  field :pubdate, type: Time
  field :featured_image_url, type: String

  validates :title, presence: true
  validates :body, presence: true

  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true
end
