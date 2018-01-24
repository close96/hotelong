class RoomsController < ApplicationController
  # 部屋一覧
  def index
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @rooms = Room.all
    .paginate(page: params[:page], per_page: 10)
    @room = Search::Room.new()
    @plans = Plan.pluck(:name, :id)
    @hoge_and = true
    @hoge_or = false
  end

  # 部屋詳細
  def show
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @room = Room.joins(:class_room).select("rooms.*, class_rooms.*").find(params[:id])
    @plans = Plan.joins(:rooms).where("room_id = ?",  params[:id])
    @options = Plan.joins(:rooms).where("room_id = ?",  params[:id]).pluck(:name, :id)
    session[:room] = params[:id]
    session[:options] = @options
  end

  def search
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    else
      @room = Search::Room.new(search_params)
      @rooms = @room.matches.order("rooms.id")
      .paginate(page: params[:page], per_page: 10)
      @plans = Plan.pluck(:name, :id)
      if @room.judge == "and"
        @hoge_and = true
        @hoge_or = false
      end
      if @room.judge == "or"
        @hoge_or = true
        @hoge_and = false
      end
      render "index"
    end
  end

  def search_params
    params.require(:search_room).permit(Search::Room::ATTRIBUTES)
  end
end
