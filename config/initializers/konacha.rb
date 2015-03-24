if defined?(Konacha)
  Konacha.configure do |config|
    if ENV['CHROME']
      Capybara.register_driver :selenium_chrome do |app|
        Capybara::Selenium::Driver.new(app, browser: :chrome)
      end

      config.driver = :selenium_chrome
    else
      require 'capybara-webkit'

      config.driver = :webkit
    end
  end
end
