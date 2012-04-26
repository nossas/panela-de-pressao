if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV["AWS_ID"],
      :aws_secret_access_key  => ENV["AWS_SECRET"]
    }
    config.fog_directory  = 'manifeste-se'
  end
end
