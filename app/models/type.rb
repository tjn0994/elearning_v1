class Type < ApplicationRecord
  belongs_to :category

  has_many :post_types
  has_many :posts, through: :post_types
end
