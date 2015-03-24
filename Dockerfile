FROM ruby:2.2.0
MAINTAINER Matt Wean <matthew.wean@gmail.com>

WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y \
  libqt5webkit5-dev \
  nodejs \
  qt5-default \
  xvfb \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/src/app

ENV PORT=3000

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install --path=vendor/bundle --without development -j4

COPY . /usr/src/app/

# Dummy DATABASE_URL to prevent error during compilation
RUN DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname RAILS_ENV=production \
  bundle exec rake assets:precompile --trace

VOLUME /usr/src/app
EXPOSE ${PORT}

CMD ["bin/rails", "console"]
