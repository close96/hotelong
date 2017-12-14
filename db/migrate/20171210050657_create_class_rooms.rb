class CreateClassRooms < ActiveRecord::Migration
  def change
    create_table :class_rooms do |t|
      t.integer :person_price, null: false			# 一人あたりの値段
      t.string :style_name, null: false				# 部屋の形式
      t.integer :expect_count, null: false			# 基本的な宿泊人数
      t.boolean  :can_add_bed, null: false			# エクストラベッドが置けるかどうか
      t.float :discount_rate, null: false			# 割引率
      t.float :surcharge_rate, null: false			# 割増率

      t.timestamps null: false
    end
  end
end
