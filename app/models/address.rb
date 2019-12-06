class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  # address入力項目
  validates :postal_code, presence: true, numericality: {only_integer: true}
  validates :prefecture_id,:house_number,:city, presence: true

end

