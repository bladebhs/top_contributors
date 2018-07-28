require 'simplecov'
require 'simplecov-console'

SimpleCov.formatter = SimpleCov.formatter = SimpleCov::Formatter::Console
SimpleCov.start

require 'rack/test'
require 'rspec'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
  Capybara.app = Sinatra::Application.new
  Capybara.server = :webrick
end

RSpec.configure do |config|
  config.include RSpecMixin
  config.include Capybara::DSL
end
