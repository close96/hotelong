class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :class_room, null: false			# 外部キー
      t.integer :room_number, null: false			# 部屋番号
      
      t.timestamps null: false
    end

    add_index :rooms, :class_room_id
  end
end