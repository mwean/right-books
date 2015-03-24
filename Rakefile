#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

RightBooks::Application.load_tasks

if Rails.env.in?(%w(test development))
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

# Spec is the default rake target.
task(:default).clear
task default: 'rubocop'
task default: 'coffeelint'
task default: 'spec:without_features'
task default: 'konacha:run'
task default: 'spec:features'
