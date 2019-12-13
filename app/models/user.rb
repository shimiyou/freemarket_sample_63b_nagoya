class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  has_many :cards
  has_one :address
  accepts_nested_attributes_for :address
  has_many :items

  #omniauth_callbacks_controllerで呼び出すメソッド
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    user = User.where(uid: uid, provider: provider).first #firstをつけないとデータが配列で返されて使いたいメソッドが使えなくて困る
   #sns_credentialsが登録されている
   if user.present?
       return user
    else
      #  userが登録されていない
      new_user  = User.new(
         nickname: auth.info.name,
         email: auth.info.email,
         uid: auth.uid,
         provider: auth.provider,
         )
        return new_user
    end
  end
  
  validates :nickname, presence: true, length: {maximum: 20}
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 7, maximum: 128}
  validates :birthday, presence: true
  validates :last_name_kana, :first_name_kana, presence: true, format: { with: /\A[ア-ン゛゜ァ-ォャ-ョー「」、]+\z/}
  validates :last_name, :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー一-龠]+\z/}
  # phone_number入力項目
  validates :phone_number, presence: true,uniqueness: true,numericality: {only_integer: true}
end
