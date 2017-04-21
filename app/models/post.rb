class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :post_types, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :types, through: :post_types

  ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'

  accepts_nested_attributes_for :post_types, allow_destroy: true

  scope :recent, ->{order created_at: :desc}
end
