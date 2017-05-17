class Members::RegisteredCoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @registered_courses = UserCourse.by_member(current_user.id).page(params[:page])
      .per Settings.per_page.member.registered_course
  end
end
