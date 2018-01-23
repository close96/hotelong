class RoomsController < ApplicationController
  # 部屋一覧
  def index
    @rooms = Room.all
    @reservations = Reservation.joins(:rooms).all
  end

  # 部屋詳細
  def show
    @room = Room.joins(:class_room).select("rooms.*, class_rooms.*").find(params[:id])
    @plans = Plan.joins(:rooms).where("room_id = ?",  params[:id])
  end
end
