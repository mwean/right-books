RSpec.configure do |config|
  config.prepend_before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed
  end
end
