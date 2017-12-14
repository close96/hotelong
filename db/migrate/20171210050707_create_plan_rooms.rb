class CreatePlanRooms < ActiveRecord::Migration
  def change
    create_table :plan_rooms do |t|
      t.references :room, null: false			# 外部キー
      t.references :plan, null: false			# 外部キー

      t.timestamps null: false
    end

    add_index :plan_rooms, :room_id
    add_index :plan_rooms, :plan_id
  end
end
