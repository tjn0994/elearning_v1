class Members::UserCoursesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @user_courses = current_user.courses
  end
end
