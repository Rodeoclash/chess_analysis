# Dockerfile used for local development

FROM ruby:2.7.0-buster

ENV LANG C.UTF-8
ENV APP_HOME /usr/src/app

RUN wget https://github.com/mcostalba/scoutfish/tarball/master && \
  tar -xzvf master && \
  cd mcostalba-scoutfish-00cec13/src && \
  make build ARCH=x86-64 && \
  mv scoutfish /usr/local/bin && \
  cd ../../ && rm -rf master && rm -rf mcostalba-scoutfish-00cec13

WORKDIR $APP_HOME

COPY . $APP_HOME

RUN bundle install
