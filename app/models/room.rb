class Room < ApplicationRecord
  belongs_to :course
  belongs_to :owner, class_name: User.name

  scope :recent, ->{order created_at: :desc}
  scope :by_author, ->(owner_id){where owner_id: owner_id}

  enum status: {active: 0, not_active: 1}
end
