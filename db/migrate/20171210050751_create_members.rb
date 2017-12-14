class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :user_id, null: false			                      # ユーザID
      t.string :password, null: false			                      # パスワード
      t.string :name, null: false				                        # 会員の名前
      t.string :address, null: false			                      # 住所
      t.integer :tel, null: false				                        # 電場番号
      t.integer :age, null: false				                        # 年齢
      t.string :email, null: false				                      # メールアドレス
      t.boolean :admin_authority, null: false, default: false	  # 管理者権限

      t.timestamps null: false
    end
  end
end
