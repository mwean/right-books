require 'zonebie'

# Coverage must be enabled before the application is loaded.
if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'

  if ENV['CIRCLE_ARTIFACTS']
    dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/vendor/'
    add_group  'Models', 'app/models'
    add_group  'Controllers', 'app/controllers'
    add_group  'Helpers', 'app/helpers'
    add_group  'Views', 'app/views'
    add_group  'Mailers', 'app/mailers'
  end
end

Zonebie.set_random_timezone

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.profile_examples = 10

  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
