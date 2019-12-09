class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
  has_many :cards
  has_one :address
  accepts_nested_attributes_for :address
  has_many :items

  def self.from_omniauth(auth)
          
    user = User.find_by(uid: auth.uid, provider: auth.provider)
    if user
            
      return user
    else     
      new_user = User.new(
        email: auth.info.email,
        nickname: auth.info.name,
        uid: auth.uid,
        provider: auth.provider,
        password: Faker::Internet.password(min_length: 8,max_length: 128)
      )
      return new_user
    end
  end
  validates :nickname, presence: true, length: {maximum: 20}
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 7, maximum: 128}
  validates :last_name,:first_name,:last_name_kana,:first_name_kana,:birthday, presence: true

  # phone_number入力項目
  validates :phone_number, presence: true,uniqueness: true,numericality: {only_integer: true}
end
