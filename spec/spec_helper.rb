require 'chefspec'
require 'chefspec/berkshelf'
require 'coveralls'

Coveralls.wear_merged! unless ENV['CI'].nil?
