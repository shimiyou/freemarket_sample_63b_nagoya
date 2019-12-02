class SignupController < ApplicationController

  def detail
    @user = User.new 
  end

  def phone_number
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    session[:birthday] = Date.new(user_params["birthday(1i)"]&.to_i,user_params["birthday(2i)"]&.to_i,user_params["birthday(3i)"]&.to_i)
    @user = User.new 
  end

  def address
    session[:phone_number] = user_params[:phone_number]
    @user = User.new 
    @user.build_address
  end

  def create
    @user = User.new(user_params_a)
    
    if @user.save!
      session[:user_id] = @user.id
      redirect_to fin_signup_index_path
    else
      render detail_signup_index_path
    end
  end
  def done
  end



  private

  def user_params
    params.require(:user).permit(
      :nickname, 
      :email, 
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
      :password,
      :birthday,
      :phone_number,
    )
  end
  def user_params_a
    params.require(:user).permit(address_attributes: [:postal_code,:prefecture_id,:city,:house_number,:build_number,:house_phone_number]).merge(
    nickname: session[:nickname], 
    email: session[:email],
    password: session[:password],
    last_name: session[:last_name], 
    first_name: session[:first_name], 
    last_name_kana: session[:last_name_kana], 
    first_name_kana: session[:first_name_kana], 
    birthday: session[:birthday], 
    phone_number: session[:phone_number]
    )
  end
end
