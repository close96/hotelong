# == Schema Information
#
# Table name: reservations
#
#  id          :integer          not null, primary key
#  room_id     :integer          not null
#  plan_id     :integer          not null
#  member_id   :integer          not null
#  guest_count :integer          not null
#  sum_price   :integer          not null
#  start_date  :date             not null
#  end_date    :date             not null
#  is_extend   :boolean          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Reservation < ActiveRecord::Base
  belongs_to :room
  belongs_to :plan
  belongs_to :member

  class << self
    def notReservedDateRoomNumberList(start_date, end_date)
      @reserved_room_number_list = Reservation.joins(:room).select("reservations.*, rooms.*")
        .where("(? <= start_date and start_date < ?) or (? <= end_date and end_date < ?)", start_date, end_date, start_date, end_date)
        .pluck(:room_number).uniq
      @not_reserved_room_number_list = Room.where.not(room_number: @reserved_room_number_list).pluck(:room_number)
      return @not_reserved_room_number_list
    end
  end
end
