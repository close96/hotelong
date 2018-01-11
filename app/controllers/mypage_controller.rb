class MypageController < ApplicationController
  def index
  	# todo: ログインの実装
  	@member = current_member
  end
end
