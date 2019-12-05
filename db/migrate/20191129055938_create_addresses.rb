class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :postal_code, null: false
      t.integer :prefecture_id, null: false, foreign_key: true
      t.string :city, null: false
      t.string :house_number, null: false
      t.string :build_number
      t.string :house_phone_number
      t.timestamps
    end
  end
end
