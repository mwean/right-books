FROM nginx:latest
MAINTAINER Matt Wean <matthew.wean@gmail.com>

RUN apt-get update \
  && apt-get install -y net-tools \
  && rm -rf /var/lib/apt/lists/*

COPY infrastructure/web/nginx.conf /etc/nginx/
COPY infrastructure/web/mime.types /etc/nginx/conf/
