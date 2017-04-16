class Notification < PublicActivity::Activity
  belongs_to :user

  scope :recent, ->{order created_at: :desc}

  enum activity_type: {active: 0, notice: 1}
end
