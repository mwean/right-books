Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false

Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

if ENV['ARTIFACTS']
  path = File.join('..', '..', '..', ENV['ARTIFACTS'], 'screenshots')
  Capybara.save_and_open_page_path = path.to_s
end
