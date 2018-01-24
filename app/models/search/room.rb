class Search::Room < Search::Base
  ATTRIBUTES = %i(
    plan
    start_date
    end_date
    person_count
    price
    judge
  )
  attr_accessor(*ATTRIBUTES)

  def initialize(params = {})
    [:start_date, :end_date].each do |attribute|
        datetimes = (1..3).map { |i| params.delete("#{ attribute }(#{ i }i)") }
        params[attribute] = Time.zone.local(*datetimes) if datetimes.any?
    end
    super
  end

  def matches
    results = ::Room.all
    if judge == "and"
      results = results.joins(:plans).select("rooms.*, plans.*")
      .where("plans.id = ?", plan.to_i)
      results = results.where(room_number: Reservation.notReservedDateRoomNumberList(start_date.strftime("%Y-%m-%d"), end_date.strftime("%Y-%m-%d"))) if start_date.present? && end_date.present?
      results = results.joins(:class_room).select("rooms.*")
      .where("expect_count >= ? or (expect_count = ? and can_add_bed = ?)", person_count.to_i, person_count.to_i - 1, true) if person_count.present?
      results = results.joins(:class_room).select("rooms.*")
      .where("person_price <= ?", price.to_i) if plan.to_i == 1 && price.present?
      results = results.joins(:class_room, :plans).select("rooms.*, plans.*")
      .where("plans.id = ? and price / apply_count <= ?", plan.to_i, price.to_i) if plan.to_i != 1 && price.present?
    end
    if judge == "or"
      results_array = []
      results_array.push(results.joins(:plans).select("rooms.*, plans.*")
      .where("plans.id = ?", plan.to_i))
      results_array.push(results.where(room_number: Reservation.notReservedDateRoomNumberList(start_date.strftime("%Y-%m-%d"), end_date.strftime("%Y-%m-%d")))) if start_date.present? && end_date.present?
      results_array.push(results.joins(:class_room).select("rooms.*")
      .where("expect_count >= ? or (expect_count = ? and can_add_bed = ?)", person_count.to_i, person_count.to_i - 1, true)) if person_count.present?
      results_array.push(results.joins(:class_room).select("rooms.*")
      .where("person_price <= ?", price.to_i)) if plan.to_i == 1 && price.present?
      results_array.push(results.joins(:class_room, :plans).select("rooms.*, plans.*")
      .where("plans.id = ? and price / apply_count <= ?", plan.to_i, price.to_i)) if plan.to_i != 1 && price.present?
      results = results.where(id: results_array.flatten.uniq)
    end
    results
  end
end