class Type < ApplicationRecord
  belongs_to :category

  has_many :courses, dependent: :destroy
  has_many :posts, dependent: :destroy
end
