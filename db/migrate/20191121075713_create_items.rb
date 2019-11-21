class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.integer :brand_id, foreign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text :description, null: false
      t.string :size, null: false
      t.string :state, null: false
      t.integer :like_count
      t.string :postage_side, null: false
      t.string :send_method, null: false
      t.string :post, null: false
      t.string :send_date, null: false
      t.timestamps
    end
  end
end
