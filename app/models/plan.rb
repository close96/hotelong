class Plan < ActiveRecord::
  has_many :reservations
  has_many :plan_rooms
  has_many :rooms, through: :plan_rooms
end
