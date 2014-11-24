desc 'lint application javascript'
task :coffeelint do
  app_success = Coffeelint.run_test_suite('app', config_file: 'coffeelint.json')
  spec_success = Coffeelint.run_test_suite('spec', config_file: 'coffeelint.json')

  fail 'Coffeelint failed!' unless app_success && spec_success
end
