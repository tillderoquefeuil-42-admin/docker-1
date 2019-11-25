FROM ruby:2.5.1

# APT
RUN apt-get update
RUN apt-get upgrade -y

# NODEJS
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -
RUN apt-get install -y nodejs

# YARN
RUN npm install -g yarn

# GEM
RUN gem install rails bundler

# CHECK VERSIONS
# RUN ruby -v && nodejs -v && rails -v && yarn -v

# COPY APP
ONBUILD COPY app/ /opt/app
ONBUILD WORKDIR /opt/app

# INIT APP
ONBUILD RUN bundle install

# DB MIGRATION
ONBUILD RUN rails db:migrate