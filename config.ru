# frozen_string_literal: true
require './config/application'

use OTR::ActiveRecord::ConnectionManagement

if ENV['RACK_ENV'] == 'development'
  $VERBOSE = nil
  use Rack::Reloader
end

run Rack::Cascade.new([Routes::V1::API])
