require_relative 'production'

Rails.application.configure do
  config.action_mailer.default_url_options = { host: 'right-books-acceptance.herokuapp.com' }

  config.log_level = :debug
end
