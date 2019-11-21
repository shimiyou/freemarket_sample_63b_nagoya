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
### Association
- has_many :items
- has_many :likes
- has_many :comments
- has_one :address
- has_one :credit
## addressテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|housse_number|string|null: false|
|build-name|string||
|phone_number_house|integer||
### Association
- belongs_to :user
## creditテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|card_number|integer|null: false,unique:true|
|expiration_date|date|null: false,unique:true|
|security_code|integer|null: false,unique:true|
### Association
- belongs_to :user
## likesテーブル
|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user
## commentsテーブル
|user_id|integer|null: false, foreign_key: true|
|item_id|integer|null: false, foreign_key: true|
|text|text|null: false|
### Association
- belongs_to :item
- belongs_to :user
## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|brand_id|integer|foreign_key: true|
|name|string|null: false|
|price|integer|null: false|
|description|text|null: false|
|size|string|null: false|
|state|string|null: false|
|like_count|integer||
|postage_side|string|null: false|
|send_method|string|null: false|
|post|string|null: false|
|send_date|string|null: false|
### Association
- has_many :likes
- has_many :comments
- has_many :images
- belongs_to :user
- belongs_to :brands
- belongs_to :categories
## categoriesテーブル
|name|string||
|ancestry|string||
### Association
- has_many :items
## brandsテーブル
|name|string|null: false|
### Association
- has_many :items
## imagesテーブル
|item_id|integer|null: false|
|image_url|string|null: false|
### Association
- belongs_to :item