class Category < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :courses, dependent: :destroy

  scope :recent, ->{order created_at: :desc}

  validates :name, presence: true, length: {maximum: 255, minimum: 2}

  scope :recent, ->{order created_at: :desc}
end
