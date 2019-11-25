require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test? #開発とテストは今まで通りに
    config.storage = :file
  elsif Rails.env.production? #本番はS3に保存する
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
      provider: 'AWS',     #AWSのアクセスキーとシークレットキーを環境変数で定義する
      aws_access_key_id: Rails.application.secrets.aws_access_key_id, #secrets.ymlに鍵の本体があります
      aws_secret_access_key: Rails.application.secrets.aws_secret_access_key,  #secrets.ymlに鍵の本体があります
      region: ap-northeast-1
    }
    config.fog_directory  = 'mercari63b'
    config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/mercari63b'
  end
end