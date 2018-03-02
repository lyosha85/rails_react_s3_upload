FROM ruby:2.5.0
MAINTAINER Alex

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs\
    postgresql-client --fix-missing --no-install-recommends

ENV APP_HOME /app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME
RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"
RUN gem install bundler
ADD . $APP_HOME

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
