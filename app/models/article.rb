class Article
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :show_text, type: String
  field :body, type: String
  field :pubdate, type: DateTime, default: nil

  belongs_to :user
  belongs_to :category

  # Validations
  validates :title, presence: true
  validates :show_text, presence: true, length: { maximum: 250, minimum: 100 }
  validates :body, presence: true
  validates :user, presence: true
  validates :category, presence: true
  validate :image_size

  scope :publish_date_desc, -> { order_by(created_at: :desc) }
  scope :published, -> { where( :pubdate.ne => nil) }
  scope :first_three_articles, -> { order_by(pubdate: :desc).limit(3) }
  scope :second_two_articles, -> { order_by(pubdate: :desc).skip(3).limit(2) }
  scope :most_read, -> { order_by(pubdate: :desc).limit(6) }
  scope :panel_articles, -> (category) { where(category: category).order_by(pubdate: :desc).limit(4) }
  #default_scope -> { where(published: true) }
  default_scope ->{ order_by(created_at: :desc) }

  mount_uploader :featured_image, FeaturedImageUploader

  private 

  def image_size
    if featured_image.size > 5.megabytes
      errors.add(:featured_image, "should be less than 5MB")
    end
  end
end
