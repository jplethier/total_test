# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'capybara/rspec'
require 'site_prism'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# Requires pages
require_relative 'pages.rb'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.order = 'random'

  config.before(:suite) do
    I18n.locale = 'pt-BR'
  end

  config.include LoginHelper, type: :feature
end
