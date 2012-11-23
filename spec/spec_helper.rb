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

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  HasBeen.tap { |app|  }
end
