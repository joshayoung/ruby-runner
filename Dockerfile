FROM ruby:2.7.2

RUN gem install bundler -v 2.0.1

WORKDIR /app

COPY Gemfile ./

# Private Gemfile:
COPY scripts/Gemfile scripts/Gemfile

RUN bundle install
RUN BUNDLE_GEMFILE=scripts/Gemfile bundle install

ENTRYPOINT ["/usr/local/bin/ruby"]