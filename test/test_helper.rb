# frozen_string_literal: true
require 'simplecov'
SimpleCov.start do
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/test/'
  add_group 'Routes',      'app/routes*'
  add_group 'Models',      'app/models'
  add_group 'Helpers',     'app/helpers'
  add_group 'Serializers', 'app/serializers'
  add_group 'Lib',         'lib'
end

ENV['RACK_ENV'] = 'test'
$VERBOSE = nil
require 'pry'
require 'minitest/autorun'
require_relative '../config/application'
require 'active_record/fixtures'

ActiveRecord::Base.logger = nil
ActiveRecord::Migration.verbose = false

DatabaseCleaner.strategy = :transaction

Dir.glob('./test/support/*.rb').each { |file| require file }

require 'mocha/mini_test'
require 'minitest-spec-context'
