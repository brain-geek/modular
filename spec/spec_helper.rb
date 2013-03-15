require 'rubygems'
require 'bundler'
Bundler.require :default, :development

require 'capybara/rspec'
require 'rails'

Combustion.initialize!

require 'rspec/rails'
require 'capybara/rails'
require 'modular/railtie'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
