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
end
