class MypageController < ApplicationController
  def index
  	if !current_member
      redirect_to :root, notice: "ログインしてください。"
    end
  end
end
