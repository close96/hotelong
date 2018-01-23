# == Schema Information
#
# Table name: rooms
#
#  id            :integer          not null, primary key
#  class_room_id :integer          not null
#  room_number   :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Room < ActiveRecord::Base
  belongs_to :class_room
  has_many :reservations
  has_many :plan_rooms
  has_many :plans, through: :plan_rooms

  class << self
    def sum_price_calculation(room_id, guest_count)
      @room = Room.joins(:class_room).select("rooms.*, class_rooms.*").where("rooms.id = ?", room_id).first
      person_price = @room.person_price
      if guest_count > @room.expect_count
        1.upto(@room.expect_count - guest_count) do
          person_price = person_price * @room.discount_rate
        end
      end
      if guest_count < @room.expect_count
        1.upto(guest_count - @room.expect_count) do
          person_price = person_price * @room.surcharge_rate
        end
      end
      sum_price = person_price * guest_count
      return sum_price
    end
  end
end
