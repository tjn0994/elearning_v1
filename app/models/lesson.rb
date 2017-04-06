class Lesson < ApplicationRecord
  belongs_to :course

  scope :recent, ->{order created_at: :desc}

  validates :name, presence: true, length: {maximum: 255, minimum: 2}
  validates :content, presence: true
end
