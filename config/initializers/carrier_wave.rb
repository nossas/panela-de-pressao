CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV["AWS_ID"],
    :aws_secret_access_key  => ENV["AWS_SECRET"],
  }
  config.fog_directory  = 'manifeste-se' 
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}

  if Rails.env.test? or Rails.env.cucumber?
    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
  end
end
