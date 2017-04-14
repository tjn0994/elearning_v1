class Exam < ApplicationRecord

  belongs_to :user
  belongs_to :lesson

  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results, allow_destroy: true,
    reject_if: :all_blank

  scope :recent, ->{order created_at: :desc}

  enum status: {not_completed: 0, completed: 1}
end
