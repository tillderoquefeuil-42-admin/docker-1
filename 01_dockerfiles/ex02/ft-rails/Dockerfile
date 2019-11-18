FROM ruby:2.6.5

# APT-GET
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential libpq-dev nodejs sqlite3 gem

# GEM
RUN gem install bundler --no-document
RUN gem install rails --no-document
RUN gem install rake -v 12.3.1 --no-document

COPY app /opt/app
WORKDIR /opt/app

RUN bundle install

COPY /app /home/app