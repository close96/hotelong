class Admin::PlansController < Admin::Base
  # プラン一覧
  def index
    @plans = Plan.where("id >= '2'")
    .paginate(page: params[:page], per_page: 5)
  end

  # プラン詳細
  def show
    @plan = Plan.find(params[:id])
  end

  # 新規作成フォーム
  def new
    @plan = Plan.new()
  end

  # 更新フォーム
  def edit
    @plan = Plan.find(params[:id])
  end

  # プランの新規登録
  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      redirect_to [:admin, @plan], notice: "プランを登録しました。"
    else
      render "new"
    end
  end

  # プラン情報の更新
  def update
    @plan = Plan.find(params[:id])
    @plan.assign_attributes(plan_params)
    if @plan.save
      redirect_to @plan, notice: "プラン情報を更新しました。"
    else
      render "edit"
    end
  end

  # プランの削除
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to :admin_plans, notice: "プランを削除しました。"
  end

  # 確認フォーム
  def confirm
    @plan = Plan.new(plan_params)
  end

  private
  def plan_params
    attrs = [:name, :apply_count, :price]
    params.require(:plan).permit(attrs)
  end
end
