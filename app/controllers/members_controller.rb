class MembersController < ApplicationController
  # 会員詳細
  def show
    @member = Member.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  def confirm
  end
end
