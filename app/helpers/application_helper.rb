module ApplicationHelper
  def full_title page_title = ""
    base_title = "Elearning"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def current_index page_index , page_size, index
    (page_index - 1)*page_size + (index + 1)
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end

  #activity
  def create_activity model, object, name
    current_user.activities.create trackable_type: model, trackable_id: object.id,
      owner_type: current_user.role, owner_id: current_user.id, key: name
  end

  #notification
  def create_notification_for_member model, object, name, user_id
    Notification.create trackable_type: model, trackable_id: object.id,
      owner_type: current_user.role, owner_id: current_user.id, key: name,
      activity_type: Notification.activity_types[:notice], user_id: user_id
  end

  def bg_unread notification
    "unread" unless notification.read
  end


  def activity_of_member activity
    case activity.trackable_type
    when "Post"
      activity.trackable.title
    when "User"
      activity.trackable.name
    when "Course"
      activity.trackable.name
    when "Category"
      activity.trackable.name
    when "Lesson"
      activity.trackable.name
    end
  end

  def event_model key
    case key
    when "create"
      "Tạo"
    when "update"
      "Cập nhật"
    when "destroy"
      "Xóa"
    when "active"
      "Chấp nhận"
    when "block"
      "Từ chối"
    end
  end

  def activity_name_of_member trackable_type
    case trackable_type
    when "Post"
      "bài viết"
    when "User"
      "thành viên"
    when "Course"
      "khóa học"
    when "Category"
      "danh mục"
    when "Lesson"
      "bài học"
    end
  end
end

