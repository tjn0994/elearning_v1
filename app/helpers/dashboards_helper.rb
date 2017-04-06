module DashboardsHelper
  def make_request_link request
    url_for controller: request.class.to_s.tableize, action: :show, id: request.id
  end
end
