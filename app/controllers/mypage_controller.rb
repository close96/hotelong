class MypageController < ApplicationController
  def index
  	if !current_member
      redirect_to :root
    end
  end
end
