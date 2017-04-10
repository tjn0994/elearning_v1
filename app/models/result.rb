class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  has_one :answer, optional: true

  scope :recent, ->{order created_at: :desc}
end
