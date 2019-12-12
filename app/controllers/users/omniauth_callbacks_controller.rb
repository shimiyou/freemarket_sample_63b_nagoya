# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_for :facebook
  end

  def google_oauth2
    callback_for :google
  end

  # common callback method
  def callback_for(provider)
    provider = provider.to_s
    @user = User.find_oauth(request.env["omniauth.auth"])
    # persisted?はデータがDBに保存されているかを確認する/配列に対しては使えないから@userを定義するときは気をつける
    if @user.persisted?
      #保存されていればログインしてroot_pathにリダイレクトされる
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      # 登録するアクションに取得した値を渡すために。sessionを利用してuserインスタンスを作成する
      session[:nickname] = @user.nickname
      session[:email] = @user.email
      session[:password] = @user.password
      session[:provider] = @user.provider
      session[:uid] = @user.uid
      #snsでのユーザ登録ではパスワードを入力させないので準備する。パスワードを作成するDeviseメソッドもある。
      #今回のバリデーションは英数字のみなのでこっちを採用
      session[:password_confirmation] = SecureRandom.alphanumeric(30)

      #登録フォームのviewにリダイレクトさせる
      redirect_to detail_signup_index_path
    end
  end

  def failure
    redirect_to root_path
  end

 end
