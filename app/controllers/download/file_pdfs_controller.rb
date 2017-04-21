class Download::FilePdfsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{current_user.name}_#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}",
          template: "pdfs/show.html.erb",
          disposition: "attachment",
          layout: "pdf",
          orientation: "Landscape",
          encoding: "UTF-8"
      end
    end
  end
end
