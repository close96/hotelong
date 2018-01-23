class RoomsController < ApplicationController
  # 部屋一覧
  def index
    @rooms = Room.all
  end

  # 部屋詳細
  def show
    @room = Room.joins(:class_room).select("rooms.*, class_rooms.*").find(params[:id])
    @plans = Plan.joins(:rooms).where("room_id = ?",  params[:id])
    @options = Plan.joins(:rooms).where("room_id = ?",  params[:id]).pluck(:name, :id)
    session[:room] = params[:id]
    session[:options] = @options
  end
end
