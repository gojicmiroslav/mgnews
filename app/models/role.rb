class Role
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :role, type: String

  validates :role, presence: true

  has_many :users
end
