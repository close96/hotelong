class ReservationsController < ApplicationController
  # 予約一覧
  def index
     @reservations = Reservation.where(member_id: current_member)
     .paginate(page: params[:page], per_page: 5)
  end

  # 予約詳細
  def show
    @reservation = Reservation.joins(:room, :plan).select("reservations.*, rooms.*, plans.*").find(params[:id])
  end

  # 新規作成フォーム
  def new
    @reservation = Reservation.new()
  end

  # 更新フォーム
  def edit
  end

  # 新規登録
  def create
  end

  # 更新
  def update
  end

  # 削除
  def destroy
  end

  # 確認フォーム
  def confirm
  end

  private
  def reservation_params
    attrs = [:room_id, :plan_id, :member_id, :guest_count, :sum_price, :start_date, :end_date, :is_extend]
    params.require(:reservation).permit(attrs)
  end
end
