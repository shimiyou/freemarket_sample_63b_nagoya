class Item < ApplicationRecord
  has_many :item_images, dependent: :destroy
  accepts_nested_attributes_for :item_images, allow_destroy: true

  belongs_to :category

  has_one :brand, dependent: :destroy
  accepts_nested_attributes_for :brand, allow_destroy: true
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :size
  belongs_to_active_hash :state
  belongs_to_active_hash :postage_side
  belongs_to_active_hash :send_method
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :send_date
  belongs_to :user
end
