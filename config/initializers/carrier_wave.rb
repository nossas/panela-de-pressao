CarrierWave.configure do |config|
  if Rails.env.development? or Rails.env.test? or Rails.env.cucumber?
    config.storage = :file
    config.enable_processing = Rails.env.development?
  else
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["AWS_ID"],
      :aws_secret_access_key  => ENV["AWS_SECRET"],
    }
    config.fog_directory  = ENV["AWS_BUCKET"]
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
end
