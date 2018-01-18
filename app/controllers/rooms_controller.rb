class RoomsController < ApplicationController
  # 部屋一覧
  def index
    @rooms = Room.all
  end

  # 部屋詳細
  def show
    @room = Room.find(params[:id])
    @plan = @room.plans.find_by(params[:id])
  end
end
