if Rails.env.production? || Rails.env.staging?
  raise "MEURIO_ACCOUNTS_URL is missing" if ENV['MEURIO_ACCOUNTS_URL'].nil?
  raise "MEURIO_HOST is missing" if ENV['MEURIO_HOST'].nil?
  raise "MEURIO_API_TOKEN is missing" if ENV['MEURIO_API_TOKEN'].nil?
  raise "POKE_TASK_TYPE_ID is missing" if ENV['POKE_TASK_TYPE_ID'].nil?
end