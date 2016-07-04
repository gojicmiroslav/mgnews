class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :show_text, type: String
  field :body, type: String
  field :pubdate, type: DateTime, default: nil
  field :featured_image_url, type: String

  validates :title, presence: true
  validates :show_text, presence: true, length: { maximum: 250 }
  validates :body, presence: true

  belongs_to :user
  belongs_to :category

  validates :user, presence: true
  validates :category, presence: true

  scope :published, -> { where( :pubdate.ne => nil) }
  scope :first_three_articles, -> { order_by(pubdate: :desc).limit(3) }
  scope :second_two_articles, -> { order_by(pubdate: :desc).skip(3).limit(2) }
  scope :most_read, -> { order_by(pubdate: :desc).limit(10) }
  scope :panel_articles, -> (category) { where(category: category).order_by(pubdate: :desc).limit(4) }
  #default_scope -> { where(published: true) }
end
