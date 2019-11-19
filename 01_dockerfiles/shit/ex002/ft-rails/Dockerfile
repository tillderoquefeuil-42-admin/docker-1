FROM ruby

EXPOSE 3000

# APT
RUN apt-get update && apt-get upgrade -y
# RUN apt-get install -y ruby-full
RUN apt-get install -y nodejs sqlite3 autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev curl git-core

# GEM
# RUN gem install rails
# RUN ruby -v && sqlite3 --version && rails --version

# RAILS
# RUN rails new myapp
# WORKDIR /myapp
# RUN rails server

ENTRYPOINT bash