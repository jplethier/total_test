source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Database
gem 'pg', '0.14.1', :require => 'pg'
gem 'activerecord-postgresql-adapter'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'
gem 'bourbon'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'haml'
gem 'haml-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Client side validation with jquery
gem 'jquery-validation-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 1.2'
gem 'ox'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  # gem 'sdoc', require: false
end

group :development, :test do
  gem 'awesome_print'
  gem 'factory_girl_rails'
  gem 'letter_opener'
  gem 'pry-nav'
  gem "rspec-rails"
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '>= 1.0.1'
  gem 'launchy'
  gem 'poltergeist'
  gem 'selenium-webdriver'
  gem 'simplecov', :require => false
  gem 'site_prism'
end

# Use unicorn as the app server
gem 'unicorn'
