require 'chefspec'
require 'chefspec/berkshelf'
require 'coveralls'

Coveralls.wear_merged! unless ENV['CI'].nil?

if ENV['SIMPLECOV'] == '1'
  require 'simplecov'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
end
