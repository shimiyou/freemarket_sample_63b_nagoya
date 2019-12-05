class AddUserIdToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :user_id, :integer, null: false, foreign_key: true
  end
end
