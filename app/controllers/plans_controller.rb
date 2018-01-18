class PlansController < ApplicationController
  # プラン一覧
  def index
    @plans = Plan.where("id >= '2'")
     .paginate(page: params[:page], per_page: 5)
  end

  # プラン詳細
  def show
    @plan = Plan.find(params[:id])
  end
end
