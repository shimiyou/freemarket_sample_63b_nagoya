class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :size_id, null: false
      t.integer :state_id, null: false
      t.integer :postage_side_id, null: false
      t.integer :send_method_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :send_date_id, null: false
      t.integer :category_id, null: false, foreign_key: true
      t.integer :brand_id, foreign_key: true
      t.timestamps
    end
  end
end
