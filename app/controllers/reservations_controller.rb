class ReservationsController < ApplicationController
  # 予約一覧
  def index
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @reservations = Reservation.where(member_id: current_member)
    .paginate(page: params[:page], per_page: 5)
  end

  # 予約詳細
  def show
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @reservation = Reservation.find(params[:id])
    @reservations = Reservation.joins(:room, :plan).select("reservations.*, rooms.*, plans.*").find(params[:id])
  end

  # 新規作成フォーム
  def new
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @reservation = Reservation.new()
    @options = session[:options]
    @room_id = session[:room]
  end

  # 新規登録
  def create
    @reservation = Reservation.new(reservation_params)
    # todo: 連泊の処理
    @reservation.is_extend = false
    if @reservation.save
      redirect_to rooms_path, notice: "予約が完了しました。"
    else
      render "new"
    end
  end

  # 削除
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: "予約を削除しました。"
  end

  # 確認フォーム
  def confirm
    @reservation = Reservation.new(reservation_params)
    room = Room.find_by(id: @reservation.room_id)
    @room_number = room.room_number
    plan = Plan.find_by(id: @reservation.plan_id)
    @plan_name = plan.name
    @room_id = session[:room]
    stay_date = @reservation.end_date - @reservation.start_date
    if @reservation.plan_id == 1
      sum_price = Room.sum_price_calculation(@reservation.room_id, @reservation.guest_count) * stay_date
    else
      plan = Plan.find_by(id: @reservation.plan_id)
      sum_price = plan.price * stay_date
    end
    @sum_price = sum_price.to_i
  end

  private
  def reservation_params
    attrs = [:room_id, :plan_id, :member_id, :guest_count, :sum_price, :start_date, :end_date, :is_extend]
    params.require(:reservation).permit(attrs)
  end
end
