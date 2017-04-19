class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform count, notification
    ActionCable.server.broadcast "notification_channel_#{notification.user_id}",
      counter: render_count_notiication(count), notification: render_notification(notification)
  end

  def render_notification notification
    DashboardController.renderer.render partial: "layouts/notification",
      locals: {collection: notification}
  end

  def render_count_notiication count
    DashboardController.renderer.render partial: "layouts/count_notification",
      locals: {count_notification: count}
  end
end

