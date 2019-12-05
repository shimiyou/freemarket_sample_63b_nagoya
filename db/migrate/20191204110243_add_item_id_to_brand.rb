class AddItemIdToBrand < ActiveRecord::Migration[5.0]
  def change
    add_column :brands, :item_id, :integer, null: false, foreign_key: true
  end
end
