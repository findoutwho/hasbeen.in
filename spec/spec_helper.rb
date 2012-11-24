PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
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
  visit "http://#{traveller}.hasbeen.in/#{location}"
end

def app
  HasBeen.tap { |app|  }
end
