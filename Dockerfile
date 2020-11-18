FROM ruby:2.7.2

RUN gem install bundler -v 2.0.1

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

ENTRYPOINT ["/usr/local/bin/ruby"]