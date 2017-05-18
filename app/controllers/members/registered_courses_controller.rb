class Members::RegisteredCoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @search = UserCourse.by_member(current_user.id).ransack(params[:q])
    @registered_courses = @search.result.page(params[:page]).per Settings.per_page.member.registered_course
    @statuses = UserCourse.statuses
    if request.xhr?
      respond_to do |format|
        format.js{}
      end
    end
  end
end
