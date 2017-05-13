class UserCourse < ApplicationRecord

  belongs_to :user
  belongs_to :course

  scope :recent, ->{order created_at: :desc}

  enum status: {pending: 0, active: 1, block: 2}
  scope :by_active, ->{where status: :active}
end
