class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
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
end