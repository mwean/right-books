if Rails.env.development?
  require 'factory_girl'

  namespace :db do
    desc 'Load a small, representative set of data so that the application can start ' \
         'in a useable state (for development).'
    task sample_data: :environment do
      FactoryGirl.find_definitions
      include FactoryGirl::Syntax::Methods

      sample_data = File.join(Rails.root, 'db', 'sample_data.rb')
      load(sample_data) if sample_data
    end
  end
end
