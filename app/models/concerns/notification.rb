class Notification < PublicActivity::Activity
  # after_create :send_notification

  belongs_to :user

  scope :recent, ->{order created_at: :desc}
  scope :by_notification, ->(type){where activity_type: type}
  scope :unread, ->{where read: false}
  scope :all_notify, ->{where activity_type: 1}

  enum activity_type: {active: 0, notice: 1}

  def send_notification
    NotificationBroadcastJob.perform_now Notification.all_notify.count, self
  end
end
