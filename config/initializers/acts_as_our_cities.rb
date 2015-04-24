ActsAsOurCities.config do |config|
  config.api_mode = Rails.env.production? || Rails.env.staging?
  config.api_site = ENV["ACCOUNTS_API_URL"]
  config.api_token = ENV["ACCOUNTS_API_TOKEN"]
end
