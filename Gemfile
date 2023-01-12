source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.0.3.5'

# new relic for app monitoring
# gem 'newrelic_rpm'
# Use Bootstrap for rails
gem 'bootstrap-sass', '~> 3.4'
gem 'mini_racer'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.2'
# Use dotenv for env variables
gem 'dotenv-rails'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# HTTParty for post call from action
gem 'httparty'
# Use Devise for authentication
gem 'devise'
# Use country_select for countries
gem 'country_select'
# Use friendly id
gem 'friendly_id', '~> 5.1'
gem 'sprockets', '~> 4.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use Social-share-button
gem 'social-share-button'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
gem 'font-awesome-rails'
gem 'inline_svg'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.9'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'koala'

gem 'mixpanel-ruby'
# for facebook authentication
gem 'omniauth-facebook'

gem 'bootsnap', '>= 1.1.0', require: false

gem 'image_processing', '~> 1.12'
gem 'webpacker', '~> 5.2.1'

gem 'aws-sdk-s3', require: false
gem 'faraday', '~> 0.17.0'
gem 'paypal-checkout-sdk'

gem 'airbrake'

gem 'exception_notification'

# Use square.rb for payment processing
gem 'square.rb'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'launchy'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  # To seed our local DBs
  gem 'faker'
  gem 'rails-erd'
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end

group :production do
  # Use skylight for request visualization
  # gem "skylight"
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# use will_paginate for page breaks
gem 'will_paginate', '~> 3.3.0'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.1'
# use spin js
gem 'simplecov', '0.17.1', require: false, group: :test
gem 'spinjs-rails'
