class Question < ApplicationRecord
  belongs_to :lesson

  has_many :answers, dependent: :destroy
  has_many :results
  has_many :exams, through: :results

  scope :recent, ->{order created_at: :desc}
end
