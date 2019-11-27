FROM ruby:2.6.5

MAINTAINER Ahmed Roshdy

RUN apt-get update && apt-get install -qq -y build-essential libpq-dev postgresql-client --fix-missing --no-install-recommends

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash

RUN apt-get install -qq -y nodejs

RUN npm install -g yarn

WORKDIR /usr/src/app

COPY Gemfile Gemfile

COPY . .

RUN bundle install

RUN yarn install --check-files

RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname SECRET_TOKEN=pickasecuretoken assets:precompile

CMD rails server
