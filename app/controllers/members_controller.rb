class MembersController < ApplicationController
  # 会員詳細
  def show
    if !current_member
      redirect_to :root
    else
      @member = Member.find(params[:id])
    end
  end

  # 新規作成フォーム
  def new
    @member = Member.new(birthday: Date.new(1980, 1, 1))
  end

  # 更新フォーム
  def edit
    if !current_member
      redirect_to :root
    else
      @member = Member.find(params[:id])
    end
  end
  
  # 会員の新規登録
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: "会員を登録しました。"
    else
      render "new"
    end
  end

  # 会員情報の更新
  def update
    @member = Member.find(params[:id])
    @member.assign_attributes(params[:member].permit(:user_id, :password, :password_confirmation, :name, :sex, :address, :tel, :birthday, :email, :admin_authority))
    if @member.save
      redirect_to @member, notice: "会員情報を更新しました。"
    else
      render "edit"
    end
  end

  # 会員の削除
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to root_path, notice: "退会しました。"
  end

  def confirm
    @member = Member.new(member_params)
  end

  private
  def member_params
    attrs = [:user_id, :password, :password_confirmation, :name, :sex, :address, :tel, :birthday, :email]
    params.require(:member).permit(attrs)
  end
end
