class Room < ActiveRecord::Base
  belongs_to :class_room
  has_many :reservations
  has_many :plan_rooms
  has_many :plans, through: :plan_rooms
end
