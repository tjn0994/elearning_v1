class Admins::TypesController < DashboardController
  before_action :authenticate_admin!
end
