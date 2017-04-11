class Question < ApplicationRecord
  belongs_to :lesson

  has_many :answers, dependent: :destroy
  has_many :results
  has_many :exams, through: :results

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:name].blank? }

  scope :recent, ->{order created_at: :desc}
end
