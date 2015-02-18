require 'capybara-slow_finder_errors' if ENV['CHECK_SLOW_FINDERS']

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

driver = ENV['CHROME'] ? :chrome : :webkit
Capybara.default_driver = driver
Capybara.javascript_driver = driver

RSpec.configure do |config|
  config.include Capybara::Angular::DSL, type: :feature

  config.before(:each, type: :feature) do
    if Capybara.current_driver == :webkit
      page.driver.block_unknown_urls
      page.driver.browser.set_skip_image_loading(true)
    end
  end

  config.after(:each, type: :feature) do
    if Capybara.current_driver == :webkit
      js_errors = page.driver.error_messages

      if js_errors.any?
        error_messages = js_errors.map { |error| " - #{error[:message]}" }

        Rails.logger.debug %(JavaScript Errors:\n#{error_messages.join("\n")})
      end
    end
  end
end
