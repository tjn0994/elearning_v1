class Answer < ApplicationRecord
  belongs_to :question

  scope :recent, ->{order created_at: :desc}
end
