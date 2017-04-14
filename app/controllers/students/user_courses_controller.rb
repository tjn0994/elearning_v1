class Students::UserCoursesController < ApplicationController
  def index
    @user_courses = current_user.courses
  end
end
