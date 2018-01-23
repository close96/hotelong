class ReservationsController < ApplicationController
  # 予約一覧
  def index
     @reservations = Reservation.where(member_id: current_member)
     .paginate(page: params[:page], per_page: 5)
  end

  # 予約詳細
  def show
    @reservation = Reservation.find(params[:id])
  end

  # 新規作成フォーム
  def new
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
end
