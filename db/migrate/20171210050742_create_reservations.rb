class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.references :room, null: false			# 外部キー
      t.references :plan, null: false			# 外部キー
      t.references :member, null: false			# 外部キー
      t.integer :guest_count, null: false		# 宿泊人数
      t.integer :sum_price, null: false			# 合計金額
      t.date :start_date, null: false		# チェックイン日
      t.date :end_date, null: false			# チェックアウト日
      t.boolean :is_extend, null: false			# 延泊であるかどうか

      t.timestamps null: false
    end

    add_index :reservations, :room_id
    add_index :reservations, :plan_id
    add_index :reservations, :member_id
  end
end
