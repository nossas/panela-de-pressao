source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '~> 3.2.12'

# Tools
gem 'pg'
gem 'thin'
gem 'inherited_resources'
gem "slim"
gem "slim-rails"
gem "formtastic", "~> 2.2.0"
gem "auto_html"
gem "redcarpet"
gem 'delayed_job_active_record'
gem 'rack-no-www'
gem 'video_info'
gem "jquery-validation-rails"
gem "schema_plus"
gem "faker"
gem "machinist", ">= 2.0.0.beta2"

# Image uplaod
gem 'carrierwave'
gem 'mini_magick'
gem "fog", "~> 1.3.1"

# Authentication
gem 'omniauth'
gem 'omniauth-oauth2'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem "cancan"

# Stuff
gem "jquery-rails"
gem 'chosen-rails'
gem 'coffee-rails'
gem 'twitter'
gem 'bitly'
gem "koala"
gem "has_scope"

group :development do
  gem "mailcatcher"
  gem "taps"
end

group :production do
  gem 'dalli'
  gem 'newrelic_rpm'
end

group :test, :development do
  gem 'rake'
  gem "rspec-rails", ">= 2.0.1"
end

# We need development here to make rake spec work
group :test, :development do
  gem 'cucumber-rails', require: false
  gem 'launchy'
  gem 'database_cleaner'
  gem "capybara"
  gem "shoulda-matchers"
  gem "jasmine"
end

group :assets do
  gem "sass-rails"
  gem "coffee-rails"
  gem "compass-rails"
  gem "compass-columnal-plugin", "~> 0.1.2"
  gem "uglifier"
end

gem 'facebox-rails'
