require 'capybara-slow_finder_errors' if ENV['CHECK_SLOW_FINDERS']

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

driver = ENV['CHROME'] ? :chrome : :webkit
Capybara.default_driver = driver
Capybara.javascript_driver = driver

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    page.driver.block_unknown_urls
    page.driver.browser.set_skip_image_loading(true)
  end
end
