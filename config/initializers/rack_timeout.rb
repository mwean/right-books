Rack::Timeout.timeout = (ENV['RACK_TIMEOUT'] || 5).to_i if defined?(Rack::Timeout)
