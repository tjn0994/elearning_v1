class UserCourseService
  def create user_ids, object
    array_user_id_temp = []
    user_ids.each do |user_id|
      array_user_id_temp << UserCourse.new(course_id: object.id, user_id: user_id)
    end

    begin
      UserCourse.import array_user_id_temp
      {success: true}
    rescue StandardError
      {success: false}
    end


  def destroy user_ids, object
    object.user_ids -= user_ids.map(&:to_i)
    {success: true}
  rescue StandardError
    {success: false}
  end
end
