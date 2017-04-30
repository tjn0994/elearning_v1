class Students::ActivitiesController < ApplicationController

  def index
    @activities = current_user.activities.load_active.page(params[:page])
      .per Settings.per_page.students.activity
  end
end
