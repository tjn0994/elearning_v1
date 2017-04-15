class Activity < PublicActivity::Activity

  belongs_to :user

  scope :load_by_user, ->user_id{where(owner_id: user_id, owner_type: "User")}
  scope :recent, ->{order created_at: :desc}

  enum activity_type: {active: 0, notice: 1}
end
