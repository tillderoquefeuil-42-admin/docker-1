FROM ruby:2.5.7

# APT
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile* /myapp/

RUN gem install json -v '1.8.3' --source 'https://rubygems.org/'
RUN bundle install

COPY . /myapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000