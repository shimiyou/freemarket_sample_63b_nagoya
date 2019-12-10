class AddCategoryIdToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :category_id, :integer, foreign_key: true, type: :string
  end
end
