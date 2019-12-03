class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
   
    added_attrs = [:nickname, :email, :last_name,:first_name_kana,:password,:birthday,:phone_number,:postal_code,:prefecture_id,:city,:house_number,:build_number,:house_phone_number ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
