FROM ruby:2.5.3-alpine

ENV APP_HOME=/app

WORKDIR $APP_HOME

RUN mkdir -p $APP_HOME

RUN apk add --update git less make

RUN gem update --system && gem install bundler

COPY . $APP_HOME/
