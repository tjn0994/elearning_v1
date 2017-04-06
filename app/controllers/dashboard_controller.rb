class DashboardController < ApplicationController

  layout "dashboard"
  include DashboardsHelper

  before_action :authenticate_user!
end
