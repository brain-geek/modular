require 'rubygems'
require 'bundler'
require 'modular'

Dir.glob('modular-app/app/components/*.rb').each {|f| require f }

Bundler.require(:default, :development)