class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]
  has_many :cards
  has_one :address
  accepts_nested_attributes_for :address
  has_many :items
  has_many :sns_credentials, dependent: :destroy

  #omniauth_callbacks_controllerで呼び出すメソッド
  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first #firstをつけないとデータが配列で返されて使いたいメソッドが使えなくて困る
  
  #sns_credentialsが登録されている
    if snscredential.present?
      user = User.where(email: auth.info.email).first

      # userが登録されていない
      unless user.present?
        user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
        )
      end
      sns = snscredential
      #返り値をハッシュにして扱いやすくする  
      #活用例 info = User.find_oauth(auth) 
            #session[:nickname] = info[:user][:nickname]
      # userが登録されていない
      { user: user, sns: sns}

      #sns_credentialsが登録されていない
    else
      user = User.where(email: auth.info.email).first

    # userが登録されている
      if user.present?
        sns = SnsCredential.create(
          uid: uid,
          provider: provider,
          user_id: user.id
        )
        { user: user, sns: sns}
      else
        user = User.new(
        nickname: auth.info.name,
        email: auth.info.email,
        )
        sns = SnsCredential.new(
          uid: uid,
          provider: provider
        )

        { user: user, sns: sns}
      end
    end
  end
  validates :nickname, presence: true, length: {maximum: 20}
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 7, maximum: 128}
  validates :last_name,:first_name,:last_name_kana,:first_name_kana,:birthday, presence: true

  # phone_number入力項目
  validates :phone_number, presence: true,uniqueness: true,numericality: {only_integer: true}
end
