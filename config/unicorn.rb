# http://unicorn.bogomips.org/
# https://blog.heroku.com/archives/2013/2/27/unicorn_rails
# http://devblog.thinkthroughmath.com/blog/2013/02/27/managing-request-queuing-with-rails-on-heroku/

listen ENV['PORT'], backlog: (ENV['UNICORN_BACKLOG'] || 16).to_i
worker_processes (ENV['UNICORN_WORKERS'] || 3).to_i
timeout (ENV['UNICORN_TIMEOUT'] || 15).to_i
preload_app true

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead.'
    Process.kill 'QUIT', Process.pid
  end

  ActiveRecord::Base.connection.disconnect! if defined?(ActiveRecord::Base)
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT.'
  end

  ActiveRecord::Base.establish_connection if defined?(ActiveRecord::Base)
end
