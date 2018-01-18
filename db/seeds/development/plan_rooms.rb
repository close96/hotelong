room_ids = %w(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)
plan_ids = %w(1 1 1 1 1 2 4 1 1 1 3 3 1 1 1 5 6 1 1 1 5 6 1 1 1)

0.upto(24) do |idx|
  PlanRoom.create(
    room_id: room_ids[idx],
    plan_id: plan_ids[idx]
  )
end 