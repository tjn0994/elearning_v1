class Exam < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :lesson

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  scope :recent, ->{order created_at: :desc}

  enum status: {not_completed: 0, completed: 1}
end
