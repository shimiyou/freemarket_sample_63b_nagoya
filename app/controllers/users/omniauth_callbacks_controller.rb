# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  def google_oauth2
    callback_from :google
  end

  private

  def callback_from(provider)
    provider = provider.to_s 
    @user = User.from_omniauth(request.env['omniauth.auth']) 
    if @user.persisted? 
      sign_in @user
      redirect_to root_path
    else
      session[:password] = @user.password
      session[:password_confirmation] = @user.password
      session[:provider] = @user.provider
      session[:uid] = @user.uid
      redirect_to detail_signup_index_path
    end
  end
end
