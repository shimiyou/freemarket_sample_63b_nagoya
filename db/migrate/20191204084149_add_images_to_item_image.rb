class AddImagesToItemImage < ActiveRecord::Migration[5.0]
  def change
    add_column :item_images, :image, :string
  end
end
