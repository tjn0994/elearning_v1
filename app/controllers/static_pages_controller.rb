class StaticPagesController < ApplicationController
  def home
  end

  def register_course
    @courses = Course.by_active.by_register_course_active
  end
end
