class Members::NotifiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifies = current_user.notifications.load_notify.page(params[:page])
      .per Settings.per_page.admins.activity
  end
end
