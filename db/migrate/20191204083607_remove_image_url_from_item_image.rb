class RemoveImageUrlFromItemImage < ActiveRecord::Migration[5.0]
  def change
    remove_column :item_images, :image_url, :string
  end
end
