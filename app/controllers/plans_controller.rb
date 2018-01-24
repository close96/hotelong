class PlansController < ApplicationController
  # プラン一覧
  def index
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @plans = Plan.where("id >= '2'")
    .paginate(page: params[:page], per_page: 5)
  end

  # プラン詳細
  def show
    if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
    @plan = Plan.find(params[:id])
  end
end
