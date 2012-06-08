# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ManifesteSe::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV["SENDGRID_USERNAME"],
  :password => ENV["SENDGRID_PASSWORD"],
  :domain => "seurio.org.br",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
