require 'bundler/setup'
require 'rake/testtask'
require 'hashie'
load 'tasks/otr-activerecord.rake'

namespace :db do
  task :environment do
    require_relative 'config/application'
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['spec/**/*_spec.rb']
end
