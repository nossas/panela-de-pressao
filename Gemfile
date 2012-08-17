source 'http://rubygems.org'

gem 'rails', '~> 3.2.6'

# Tools
gem 'pg'
gem 'thin'
gem "foreigner"
gem 'inherited_resources'
gem "slim"
gem "slim-rails"
gem "formtastic", "~> 2.2.0"
gem "auto_html"
gem "redcarpet"
gem 'delayed_job_active_record'

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
  gem "heroku"
  gem "taps"
end

group :production do
  gem 'dalli'
  gem 'newrelic_rpm'
end


# We need development here to make rake spec work
group :test, :development do
  gem 'rake'
  gem 'cucumber-rails', require: false
  gem 'launchy'
  gem 'database_cleaner'
  gem "capybara", "~> 1.1.2"
  gem "rspec-rails", ">= 2.0.1"
  gem "shoulda-matchers"
  gem "machinist", ">= 2.0.0.beta2"
  gem "jasmine"
end

group :assets do
  gem "sass-rails"
  gem "coffee-rails"
  gem "compass-rails"
  gem "compass-columnal-plugin", "~> 0.1.2"
  gem "uglifier"
end

