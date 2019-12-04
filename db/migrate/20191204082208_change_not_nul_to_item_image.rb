class ChangeNotNulToItemImage < ActiveRecord::Migration[5.0]
  def change
    change_column_null :item_images, :image_url, true
  end
end
