class MypageController < ApplicationController
  def index
  	if !current_member
      redirect_to :root
    end
    @member = current_member
  end
end
