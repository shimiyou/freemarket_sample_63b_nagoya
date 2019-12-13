# freemarket_sample_63b_nagoya DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false,unique:true|
|password|string|null: false|
|nickname|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|phone_number|integer|null: false,unique:true|
|birthday|date|null: false|
|provider|string||
|uid|string||
### Association
- has_many :items
- has_one :address
- accepts_nested_attributes_for :address
- has_many :cards

## addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture_id|integer|null: false|
|city|string|null: false|
|housse_number|string|null: false|
|build_number|string||
|house_phone_number|integer||
### Association
- belongs_to_active_hash :prefecture
- belongs_to :user
## cardsテーブル
|user_id|integer|null: false, foregin_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|brand_id|integer|foreign_key: true|
|name|string|null: false|
|price|integer|null: false|
|description|text|null: false|
|size_id|integer|null: false, foregin_key: true|
|state_id|integer|null: false, foregin_key: true|
|postage_side_id|integer|null: false, foregin_key: true|
|send_method_id|integer|null: false, foregin_key: true|
|prefecture_id|integer|null: false, foregin_key: true|
|send_date_id|integer|null: false, foregin_key: true|
|category_id|integer|null: false, foregin_key: true|
|purchaser_id|integer|foregin_key: true|
### Association
- has_many :item_images, dependent: :destroy
- accepts_nested_attributes_for :item_images, allow_destroy: true
- belongs_to :category
- belongs_to :user
- has_one :brand, dependent: :destroy
- accepts_nested_attributes_for :brand, allow_destroy: true
- belongs_to_active_hash :size
- belongs_to_active_hash :state
- belongs_to_active_hash :postage_side
- belongs_to_active_hash :send_method
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :send_date
## categoriesテーブル
|name|string||
|ancestry|string||
### Association
- has_many :items
- has_ancestry
## brandsテーブル
|name|string|null: false|
|item_id|string|null: false, foregin_key: true|
### Association
- belongs_to :item, optional: true
## item_imagesテーブル
|item_id|integer|null: false|
|image|string|null: false|
### Association
- belongs_to :item
