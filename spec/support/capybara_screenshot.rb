Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false

if ENV['CIRCLE_ARTIFACTS']
  path = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'screenshots')
  Capybara.save_and_open_page_path = path.to_s
end
