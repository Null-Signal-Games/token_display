FROM ruby:3.2.2

WORKDIR /usr/src/app

RUN apt update

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN bundle config --global frozen 1

# Finish establishing our Ruby enviornment
RUN bundle install

ENTRYPOINT ["./entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
