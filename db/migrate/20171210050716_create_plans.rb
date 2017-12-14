class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name, null: false			# プランの名前
      t.integer :apply_count, null: false	# 適用人数
      t.integer :price, null: false			# プランの金額

      t.timestamps null: false
    end
  end
end
