class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :question
  belongs_to :answer, optional: true

  scope :recent, ->{order created_at: :desc}
end
