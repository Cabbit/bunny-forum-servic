# frozen_string_literal: true
require 'ostruct'
require 'pathname'
require 'yaml'
require 'globalize'
require 'paperclip'
require 'aws-sdk'

I18n.load_path += Dir['config/locale/*.yml']
I18n.locale = :en
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

# Load environment settings
Config = OpenStruct.new
Config.env = ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development
Config.root = Pathname.new(File.expand_path('../..', __FILE__))

# Load dependencies
require 'bundler'
Bundler.require(:default, Config.env)

Paperclip::Attachment.default_options[:storage] = :s3
Paperclip::Attachment.default_options[:s3_credentials] = {
  bucket:            ENV['S3_BUCKET'],
  access_key_id:     ENV['S3_ACCESS_KEY'],
  secret_access_key: ENV['S3_SECRET']
}
Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
