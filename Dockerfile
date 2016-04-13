FROM ruby:2.3

ENV HOMEDIR /myapp
ENV BUNDLE_PATH=/bundle

RUN useradd kevin --no-create-home
RUN  \
  mkdir $BUNDLE_PATH && \
  chown -R kevin:kevin $BUNDLE_PATH

USER kevin

WORKDIR $HOMEDIR
