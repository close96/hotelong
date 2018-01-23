class RoomsController < ApplicationController
  # 部屋一覧
  def index
    @rooms = Room.all
  end

  # 部屋詳細
  def show
    @room = Room.joins("join class_rooms on class_rooms.id = rooms.class_room_id").select("rooms.*, class_rooms.*").find(params[:id])
    @plan = @room.plans.find_by(params[:id])
  end
end
