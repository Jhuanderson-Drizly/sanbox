FROM ruby
LABEL maintainer engineering@drizly.com

VOLUME /app/build

WORKDIR /app

COPY Gemfile /app/Gemfile
RUN true \
    && bundle install --path /vendor/bundle

RUN gem install sequel
RUN gem install mysql2
RUN gem install faker
COPY . .

CMD ["ruby" ,"./app/db_update.rb"]