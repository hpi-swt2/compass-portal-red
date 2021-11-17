source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'

#
# Rails essentials
#

# The application framework
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use Puma as the development server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript, Webpacker is the default JavaScript compiler for Rails 6
# Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster.
# When you follow a link, Turbolinks automatically fetches the page, swaps in its <body>, and merges its <head>
# Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

#
# Additional core gems
#

# Use devise as an authentication solution
gem 'devise' # https://github.com/plataformatec/devise
gem 'devise-i18n' # https://github.com/tigrish/devise-i18n
gem 'devise-bootstrap-views' # https://github.com/hisea/devise-bootstrap-views
gem 'devise-i18n-bootstrap' # https://github.com/maximalink/devise-i18n-bootstrap
# Libraries for openID Connect authentication
gem 'omniauth' # https://github.com/omniauth/omniauth
gem 'omniauth_openid_connect' # https://github.com/m0n9oose/omniauth_openid_connect

#
# Gems that are loaded depending on the environment (development/test/production)
#

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', '~> 1.4' # https://www.sqlite.org/index.html
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] # https://github.com/deivid-rodriguez/byebug
  # RSpec testing framework as a drop-in alternative to Rails' default testing framework, Minitest
  gem 'rspec-rails', '~> 5.0.0' # https://github.com/rspec/rspec-rails
  # Factories instead of test fixtures
  gem 'factory_bot_rails' # https://github.com/thoughtbot/factory_bot_rails
  # Ruby static code analyzer (aka linter)
  gem 'rubocop', '~> 1.23', require: false # https://github.com/rubocop-hq/rubocop
  # Rails Extension for Rubocop
  gem 'rubocop-rails', require: false # https://github.com/rubocop-hq/rubocop-rails
  # rspec Extension for Rubocop
  gem 'rubocop-rspec', require: false # https://github.com/rubocop-hq/rubocop-rspec
  # Performance optimization analysis for your projects
  gem 'rubocop-performance', require: false # https://github.com/rubocop-hq/rubocop-performance
  # RSpec formatter compatible with GitHub Action's annotations
  gem 'rspec-github', require: false # https://github.com/Drieam/rspec-github
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0' # https://github.com/rails/web-console
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Replaces standard Rails error page with a more useful error page
  gem 'better_errors' # https://github.com/BetterErrors/better_errors
  # binding_of_caller is optional, but is necessary to use Better Errors' advanced features
  gem 'binding_of_caller' # https://github.com/banister/binding_of_caller
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # Capybara: Test web applications by simulating how a real user would interact with your app
  gem 'capybara', '>= 3.26' # https://github.com/teamcapybara/capybara
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers' # https://github.com/titusfortner/webdrivers
  # Provides one-liners to test common rails functionality, that, if written by hand, would be much longer
  gem 'shoulda-matchers', '~> 5.0' # https://github.com/thoughtbot/shoulda-matchers
  # Code coverage analysis tool for Ruby
  gem 'simplecov', '~> 0.17.0', require: false # https://github.com/simplecov-ruby/simplecov
end

group :production do
  # https://devcenter.heroku.com/articles/sqlite3
  gem 'pg' # production database runs on postgres
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
