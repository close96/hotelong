class Admin::MembersController < Admin::Base
  # 会員一覧
  def index
    @members = Member.all
    .paginate(page: params[:page], per_page: 5)
  end

  # 会員詳細
  def show
    @member = Member.find(params[:id])
  end

  # 更新フォーム
  def edit
    @member = Member.find(params[:id])
  end

  # 会員情報の更新
  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(member_params)
    if @member.save
      redirect_to [:admin, @member], notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  # 会員の削除
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to :admin_members, notice: "会員を削除しました。"
  end

  # 確認フォーム
  def confirm
    @member = Member.new(member_params)
  end

  private
  def member_params
    attrs = [:user_id, :password, :password_confirmation, :name, :sex, :address, :tel, :birthday, :email, :admin_authority]
    params.require(:member).permit(attrs)
  end
end
