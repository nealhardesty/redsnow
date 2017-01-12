FROM ubuntu:latest
MAINTAINER nealhardesty@yahoo.com

RUN apt-get update -y && apt-get install -y build-essential ruby ruby-dev libncurses5-dev && rm -rf /var/lib/apt/lists/*
ADD . /redsnow
WORKDIR /redsnow
RUN gem install bundler
RUN bundle install
CMD ./redsnow.rb
