FROM ruby:2.7.2-slim

RUN mkdir -p /var/emrld
WORKDIR /var/emrld

RUN apt-get update -qq && apt-get install -qq \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV SECRET_KEY_BASE 1

COPY Gemfile /var/emrld/Gemfile
COPY Gemfile.lock /var/emrld/Gemfile.lock

RUN gem install bundler:2.4.5
RUN bundle install

COPY . /var/emrld

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]