FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y postgresql-client
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
EXPOSE 3000

ENV RAILS_ENV production

RUN bin/delayed_job start

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]