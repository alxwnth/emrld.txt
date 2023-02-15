FROM ruby:2.7.2-slim

RUN apt-get update && apt-get install -y npm

RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

RUN bundle install

CMD rails s -b 0.0.0.0