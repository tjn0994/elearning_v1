class DashboardController < ApplicationController
  layout "dashboard"

  include ApplicationHelper
  include DashboardsHelper

  before_action :authenticate_user!
end
