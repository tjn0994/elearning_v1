class StaticPagesController < ApplicationController
  def home
    @home = true
    @courses = Course.all
    @members = User.all
    @teachers = User.by_teacher
  end
end
