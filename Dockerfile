FROM ruby:2.7.2

RUN gem install bundler -v 2.0.1

WORKDIR /app

COPY Gemfile ./

# Private Gemfile:
# Adding the '*' here makes this an option copy. I have to have an actual file that exists before this, hence the '.keep':
COPY scripts/.keep scripts/Gemfile* scripts/Gemfile

RUN bundle install
RUN BUNDLE_GEMFILE=scripts/Gemfile bundle install

ENTRYPOINT ["/usr/local/bin/ruby"]