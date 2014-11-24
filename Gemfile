source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby '2.1.5'

gem 'active_model_serializers', '~> 0.9.0'
gem 'angular-rails-templates'
gem 'annotate', '~> 2.6.5'
gem 'autoprefixer-rails'
gem 'awesome_print'
gem 'bitters'
gem 'bourbon'
gem 'coffee-rails'
gem 'cssminify'
gem 'friendly_id'
gem 'gon'
gem 'high_voltage', '~> 2.2.1'
gem 'i18n-tasks', '~> 0.7.8'
gem 'jquery-rails'
gem 'neat'
gem 'newrelic_rpm', '>= 3.7.3'
gem 'ngannotate-rails'
gem 'oj'
gem 'pg'
gem 'rack-canonical-host'
gem 'rails', '~> 4.2.0.beta4'
gem 'rails-assets-angular'
gem 'rails-assets-lodash'
gem 'rails-assets-normalize.css'
gem 'sass-rails', '~> 5.0.0.beta1'
gem 'simple_form', github: 'plataformatec/simple_form' # Fixes Rails deprecation notice
gem 'slim-rails'
gem 'sorcery'
gem 'uglifier'
gem 'unicorn'

group :production, :acceptance do
  gem 'heroku_rails_deflate'
  gem 'rack-cache'
  gem 'rack-timeout'
  gem 'rails_stdout_logging'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'poltergeist'
  gem 'rack_session_access'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'simplecov'
  gem 'zonebie'
end

group :test, :development do
  gem 'byebug'
  gem 'coffeelint', '~> 0.4.0'
  gem 'dotenv-rails'
  gem 'konacha'
  gem 'pry'
  gem 'rails-assets-angular-mocks'
  gem 'rails-assets-rosie'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.27.0', require: false
  gem 'rubocop-rspec', require: false
  gem 'site_prism'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'faker'
  gem 'guard', '~> 2.6.1'
  gem 'guard-livereload'
  gem 'launchy'
  gem 'quiet_assets'
  gem 'rack-livereload'
  gem 'rb-fsevent'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'terminal-notifier-guard'
end
