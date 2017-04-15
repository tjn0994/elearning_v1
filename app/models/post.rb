class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :post_types
  has_many :types, through: :post_types

  accepts_nested_attributes_for :post_types, allow_destroy: true

  scope :recent, ->{order created_at: :desc}
end
