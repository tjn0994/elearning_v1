class Type < ApplicationRecord
  belongs_to :category

  has_many :courses
  has_many :posts
end
