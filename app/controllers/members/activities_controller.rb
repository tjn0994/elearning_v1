class Members::ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @search = current_user.activities.load_active.ransack(params[:q])
    @activities = current_user.activities.load_active.page(params[:page])
      .per Settings.per_page.members.activity
    # if request.xhr?
    #   respond_to do |format|
    #     format.js{}
    #   end
    # end
  end
end
