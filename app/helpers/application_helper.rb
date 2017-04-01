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
end
