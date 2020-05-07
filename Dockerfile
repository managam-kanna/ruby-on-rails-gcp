FROM ruby:2.6.3

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /ruby-on-rails-gcp
WORKDIR /ruby-on-rails-gcp

RUN gem install bundler:2.1.4

COPY Gemfile /ruby-on-rails-gcp/Gemfile
COPY Gemfile.lock /ruby-on-rails-gcp/Gemfile.lock

RUN bundle install
COPY . /ruby-on-rails-gcp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8080

# Start the main process.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]