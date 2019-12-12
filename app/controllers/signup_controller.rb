class SignupController < ApplicationController
  before_action :validates_detail, only: :phone_number
  before_action :validates_phone_number, only: :address
  before_action :validates_address, only: :create
  before_action :authenticate_user!, only: :done

  def index
    redirect_to root_path if user_signed_in?
  end

  def detail
    if session[:password_confirmation]
      @user = User.new(
    #omniauth_callbacks_controllerで定義したsession
        nickname: session[:nickname],
        email: session[:email],
        password: session[:password_confirmation],
        password_confirmation: session[:password_confirmation]
      )
    else
      @user = User.new
    end
  end

  def detail_validates
    # step2にデータを渡すためにsessionに入れる
    create_session(user_params)
    @user.valid?
  end

  def step2
    @user = User.new
  end

  def creation
    set_user_with_session
    @user[:phonenumber] = user_params[:phonenumber]
    if @user.save
      SnsCredential.create(  #ユーザ登録と同時にこっちも登録
        uid: session[:uid],
        provider: session[:provider],
        user_id: @user.id
      )
      sign_in User.find(@user.id) unless user_signed_in?
      redirect_to addresses_path
    else
      render :step2
    end
  end

  def done; end
  


  def set_user_with_session
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password_confirmation],
      password_confirmation: session[:password_confirmation],
      lastname: session[:lastname],
      firstname: session[:firstname],
      lastname_kana: session[:lastname_kana],
      firstname_kana: session[:firstname_kana],
      birthday_year: session[:birthday_year],
      birthday_month: session[:birthday_month],
      birthday_day: session[:birthday_day]
    )
  end


  

  def phone_number
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    if session[:password_confirmation]
      session[:password] = session[:password_confirmation]
    else
      session[:password] = user_params[:password]
    end
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
    @user.provider = session[:provider]
    @user.uid = session[:uid]
    if @user.save!
      session[:user_id] = @user.id
      sign_in User.find(@user.id) unless user_signed_in?
      redirect_to new_card_path(@user.id)
    else
      render detail_signup_index_path
    end
    end
  end


  def fin
  end


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
      :password_confirmation
    )
  end

  def user_params_a
    params.require(:user).permit(address_attributes: [:id,:postal_code,:prefecture_id,:city,:house_number,:build_number,:house_phone_number]).merge(
    nickname: session[:nickname], 
    email: session[:email],
    password: session[:password],
    last_name: session[:last_name], 
    first_name: session[:first_name], 
    last_name_kana: session[:last_name_kana], 
    first_name_kana: session[:first_name_kana], 
    birthday: session[:birthday], 
    phone_number: session[:phone_number],
    password_confirmation: session[:password_confirmation]
    )
  end
  def validates_detail
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    if session[:password_confirmation]
      session[:password] = session[:password_confirmation]
    else
      session[:password] = user_params[:password]
    end
    session[:last_name] = user_params[:last_name]
    session[:first_name] = user_params[:first_name]
    session[:last_name_kana] = user_params[:last_name_kana]
    session[:first_name_kana] = user_params[:first_name_kana]
    if
      user_params["birthday(1i)"] == "" || user_params["birthday(2i)"] == "" || user_params["birthday(3i)"] == "" 
      session[:birthday] = ""
    else
      session[:birthday] = Date.new(user_params["birthday(1i)"].to_i,user_params["birthday(2i)"].to_i,user_params["birthday(3i)"].to_i)
    end
    # バリデーション用に、仮でインスタンスを作成する
    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday: session[:birthday],
      phone_number: "01099199991",
      password_confirmation: session[:password_confirmation],
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う

   render '/signup/detail' unless @user.valid?
  end


  def validates_phone_number
    session[:phone_number] = user_params[:phone_number]

    @user = User.new(
      nickname: session[:nickname], # sessionに保存された値をインスタンスに渡す
      email: session[:email],
      password: session[:password],
      last_name: session[:last_name],
      first_name: session[:first_name],
      last_name_kana: session[:last_name_kana],
      first_name_kana: session[:first_name_kana],
      birthday: session[:birthday],
      phone_number: session[:phone_number],
      password_confirmation: session[:password_confirmation],
    )
    # 仮で作成したインスタンスのバリデーションチェックを行う
    render '/signup/phone_number' unless @user.valid? 
  end
  def validates_address
    @user = User.new(
      
      params.require(:user).permit(address_attributes: [:id,:postal_code,:prefecture_id,:city,:house_number,:build_number,:house_phone_number]).merge!(
        nickname: session[:nickname], 
        email: session[:email],
        password: session[:password],
        last_name: session[:last_name], 
        first_name: session[:first_name], 
        last_name_kana: session[:last_name_kana], 
        first_name_kana: session[:first_name_kana], 
        birthday: session[:birthday], 
        phone_number: session[:phone_number],
        password_confirmation: session[:password_confirmation],
      )
    )
    render address_signup_index_path unless @user.valid?
  end


