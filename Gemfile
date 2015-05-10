source 'https://rubygems.org'

ruby '2.2.0'

gem 'active_model_serializers', '~> 0.9.0'
gem 'ancestry'
gem 'angular-rails-templates'
gem 'annotate', '~> 2.6.5'
gem 'autoprefixer-rails'
gem 'awesome_print', require: 'ap'
gem 'bitters'
gem 'bourbon'
gem 'chronic'
gem 'coffee-rails'
gem 'cssminify'
gem 'friendly_id'
gem 'gon'
gem 'high_voltage', '~> 2.2.1'
gem 'jquery-rails'
gem 'neat'
gem 'newrelic_rpm', '>= 3.7.3'
gem 'ngannotate-rails'
gem 'oj'
gem 'ox', '~> 2.1.8'
gem 'pg'
gem 'rails', '~> 4.2.0'
gem 'redis'
gem 'rollbar', '~> 1.4.4'
gem 'sass-rails', '~> 5.0.1'
gem 'simple_form', '~> 3.1.0'
gem 'slim-rails'
gem 'sorcery', '~> 0.9.0'
gem 'uglifier'
gem 'unicorn'
gem 'vacuum'

source 'https://rails-assets.org' do
  gem 'rails-assets-angular'
  # Waiting for bugfix https://github.com/isteven/angular-multi-select/issues/205
  gem 'rails-assets-angular-multi-select', '~> 2.0.2'
  gem 'rails-assets-angular-redactor'
  gem 'rails-assets-angular-ui-sortable'
  gem 'rails-assets-jquery-ui'
  gem 'rails-assets-lodash'
  gem 'rails-assets-moment'
  gem 'rails-assets-normalize.css'
end

group :production, :acceptance do
  gem 'heroku_rails_deflate'
  gem 'rack-cache'
  gem 'rack-timeout'
  gem 'rails_12factor'
end

group :test do
  gem 'capybara'
  gem 'capybara-angular', github: 'mwean/capybara-angular'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'rack_session_access'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'simplecov'
  gem 'zonebie'
end

group :test, :development do
  gem 'brakeman'
  gem 'byebug'
  gem 'capybara-slow_finder_errors', require: false
  gem 'coffeelint', '~> 0.4.0'
  gem 'dotenv-rails', '~> 2.0.0'
  gem 'eventmachine', '~> 1.0.4'
  gem 'faker'
  gem 'i18n-tasks', '~> 0.7.8'
  gem 'konacha'
  gem 'pry'
  gem 'rails-assets-angular-mocks'
  gem 'rails-assets-rosie'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.31.0', require: false
  gem 'rubocop-rspec', require: false
  gem 'site_prism'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard', '~> 2.6.1'
  gem 'guard-livereload'
  gem 'launchy'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'rack-livereload'
  gem 'rb-fsevent'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'terminal-notifier-guard'
end
