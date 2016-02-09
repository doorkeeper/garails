require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'capybara/rspec'

Combustion.initialize! :action_controller, :action_view

require 'rspec/rails'
require 'capybara/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
