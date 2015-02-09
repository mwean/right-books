require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: true,
    phantomjs_options: ['--load-images=false']
  )
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_driver = :rack_test
Capybara.javascript_driver = (ENV['CHROME'] || ENV['CI']) ? :chrome : :poltergeist

RSpec.configure do |config|
  config.before(:each, js: true) do
    page.driver.browser.url_blacklist = [
      'http://use.typekit.net/zpc4pgn.js',
      'http://example.com/image.jpg'
    ]
  end
end
