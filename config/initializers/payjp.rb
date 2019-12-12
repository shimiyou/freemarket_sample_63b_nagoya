Rails.configuration.payjp = {
  payjp_private_key: Rails.application.secrets.payjp_private_key,
  payjp_key: Rails.application.secrets.payjp_key
}

Payjp.api_key = Rails.application.secrets.payjp_key