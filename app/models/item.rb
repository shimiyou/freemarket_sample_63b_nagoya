class Item < ApplicationRecord
  belongs_to :category
  mount_uploader :image, ImageUploader
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :size
  belongs_to_active_hash :state
  belongs_to_active_hash :postage_side
  belongs_to_active_hash :send_method
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :send_date
end
