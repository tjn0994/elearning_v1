class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  serialize :answer_ids, Array

  scope :recent, ->{order created_at: :desc}
end
