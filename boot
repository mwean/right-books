#!/usr/bin/env bash

docker run -d --name redis mwean/right-books-redis
docker run -d --name db -v /var/lib/postgresql/data mwean/right-books-db

if [ "$1" == "test" ]; then
  DATABASE_URL=postgresql://db/right-books-test?pool=5

  docker run -d --name app -e "RAILS_ENV=test" -e "SECRET_KEY_BASE=testing" \
  -e "DATABASE_URL=$DATABASE_URL" --link db:db --link redis:redis mwean/right-books-app \
  tail -f /dev/null
else
  DATABASE_URL=postgresql://db/right-books?pool=5

  docker run -d --name app -e "RAILS_ENV=production" -p "3000:3000" -e "DATABASE_URL=$DATABASE_URL" \
  --link db:db --link redis:redis mwean/right-books-app bundle exec unicorn -c ./config/unicorn.rb

  docker run -d --name web --link app:app -p "80:80" --volumes-from app mwean/right-books-web
fi
