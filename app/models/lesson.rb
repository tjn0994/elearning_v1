class Lesson < ApplicationRecord
  belongs_to :course

  scope :recent, ->{order created_at: :desc}
end
