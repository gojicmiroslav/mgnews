class Category
	include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :menu_order, type: Integer

  validates :name, presence: true
  validates :menu_order, presence: true
  validates :menu_order, uniqueness: true

  has_many :articles

  scope :ordered, -> { order_by(menu_order: :asc).limit(6) }
  scope :order_for_dropdown_menu, -> { order_by(menu_order: :asc).skip(6) }
end