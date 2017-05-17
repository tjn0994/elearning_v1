class UserCourse < ApplicationRecord

  belongs_to :user
  belongs_to :course

  scope :recent, ->{order created_at: :desc}
  scope :by_active, ->{where status: :active}
  scope :by_not_active, ->{where.not(status: :active)}
  scope :by_author, ->(owner_id) do
    joins(:course)
      .where("courses.owner_id = ?", owner_id)
  end
  scope :by_member, ->(id){where user_id: id}

  enum status: {pending: 0, active: 1, block: 2}

  delegate :name, :email, :number_of_phone, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :course, prefix: true, allow_nil: true
end
