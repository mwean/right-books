if defined?(Konacha)
  Konacha.configure do |config|
    if ENV['CI']
      Capybara.register_driver :selenium_chrome do |app|
        Capybara::Selenium::Driver.new(app, browser: :chrome)
      end

      config.driver = :selenium_chrome
    else
      require 'capybara/poltergeist'
      config.driver = :poltergeist
    end
  end
end
