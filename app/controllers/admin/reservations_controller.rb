class Admin::ReservationsController < Admin::Base
  # 予約一覧
  def index
    @reservations = Reservation.all
    .paginate(page: params[:page], per_page: 5)
  end

  # 予約詳細
  def show
    @reservation = Reservation.find(params[:id])
    @reservations = Reservation.joins(:room, :plan, :member).select("reservations.*, rooms.*, plans.*, members.*").find(params[:id])
  end

  # 削除
  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to :admin_reservations, notice: "予約を削除しました。"
  end

  private
  def reservation_params
    attrs = [:room_id, :plan_id, :member_id, :guest_count, :sum_price, :start_date, :end_date, :is_extend]
    params.require(:reservation).permit(attrs)
  end
end
