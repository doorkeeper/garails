ENV["RAILS_ENV"] = "test"
$:.unshift File.dirname(__FILE__)

require 'test_app/config/environment'
require 'rails/test_help'
require 'webmock/test_unit'
require 'flexmock/test_unit'

