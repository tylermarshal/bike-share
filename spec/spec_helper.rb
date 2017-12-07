ENV["RACK_ENV"] ||= "test"

require 'bundler'
Bundler.require(:default, :test)
require File.expand_path("../../config/environment", __FILE__)
require 'rspec'
require 'capybara/dsl'
require_relative '../db/seed_fixture'

Capybara.app = BikeShareApp


DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before(:each) do
    DatabaseCleaner.clean
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each, :foo => true) do
    DatabaseCleaner.clean
    Seed.test
  end
end
