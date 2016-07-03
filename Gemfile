# frozen_string_literal: true
ruby '2.3.1'
source 'https://rubygems.org'

gem 'rack'
gem 'grape'
gem 'grape-swagger'
gem 'rake'
gem 'rubocop', require: false
gem 'simplecov', require: false, group: :test
gem 'configatron'
gem 'globalize', '~> 5.0.0'
gem 'jsonapi-serializers'
gem 'activerecord', require: 'active_record'
gem 'grape-activerecord'
gem 'grape-cache_control'
gem 'puma'
gem 'mysql2'
gem 'paperclip'
gem 'paperclip-rack', require: 'paperclip/rack'
gem 'aws-sdk', '< 2.0'
gem 'mocha'
gem 'minitest-spec-context'
gem 'grape_json_api_streamer', '>= 0.0.3'

group :development do
  gem 'pry'
  gem 'pry-remote'
end

group :test do
  gem 'rack-test', require: 'rack/test'
  gem 'database_cleaner'
end
