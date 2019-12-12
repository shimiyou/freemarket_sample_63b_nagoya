class AddPurchaserIdToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :purchaser_id, :integer
  end
end
