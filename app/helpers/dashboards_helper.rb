module DashboardsHelper
  def make_request_link request
    url_for controller: request.class.to_s.tableize, action: :show, id: request.id
  end

  def label_css request
    case request.status
    when Settings.status.discard
      "label-danger"
    when Settings.status.pending
      "label-warning"
    when Settings.status.approver
      "label-success"
    end
  end
end
