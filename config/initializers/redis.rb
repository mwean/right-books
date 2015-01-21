redis_url_key = ENV['REDIS_URL_KEY']
ENV['REDIS_URL'] = ENV[redis_url_key] if redis_url_key
