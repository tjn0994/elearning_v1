class Publish::RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.by_author(current_user.id).by_active.recent
  end

  def show
    @room = Room.find_by id: params[:id]
    if @room.not_active?
      flash[:error] = "Hiện tại phòng đang đóng cửa"
      redirect_to root_path
    else
      if @room.course.user_ids.include?(current_user.id) || (@room.course.owner.id == current_user.id)
        if @opentok.nil?
         @opentok = OpenTok::OpenTok.new(ENV["KEY_OPENTOK"], ENV["TOKEN"])
        end
        @tok_token = @opentok.generate_token @room.session_id
      else
        flash[:error] = "Bạn không có quyền vào phòng này"
        redirect_to root_path
      end
    end
    # @tok_token = @opentok.generate_token session_id: @room.session_id
  end
end
