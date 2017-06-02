ENV['RACK_ENV'] = 'test' unless ENV['RACK_ENV']

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'

Capybara.configure do |config|
  config.app = Padrino.application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara::DSL
end

def visit_profile(traveller, location = '')
  visit "http://#{traveller}.test.hasbeen.in/#{location}"
end

def app
  HasBeen.tap { |app|  }
end
