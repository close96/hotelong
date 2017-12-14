class PlanRoom < ActiveRecord::Base
  belongs_to :room
  belongs_to :plan
end
