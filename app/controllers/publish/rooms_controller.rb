class Publish::RoomsController < ApplicationController

  def index
    @rooms = Room.by_author(current_user.id).recent
  end

  def show
    if @opentok.nil?
     @opentok = OpenTok::OpenTok.new(ENV["KEY_OPENTOK"], ENV["TOKEN"])
    end
    @room = Room.find_by id: params[:id]
    @tok_token = @opentok.generate_token @room.session_id
    # @tok_token = @opentok.generate_token session_id: @room.session_id
  end
end
