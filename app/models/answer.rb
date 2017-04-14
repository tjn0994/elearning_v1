class Answer < ApplicationRecord
  has_one :result

  belongs_to :question

  scope :recent, ->{order created_at: :desc}
end
