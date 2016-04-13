FROM ruby:2.3

ENV HOMEDIR /myapp
ENV ES_URL elasticsearch:9200
ENV ES_INDEX benchmark_es

RUN useradd kevin --no-create-home

WORKDIR HOMEDIR
