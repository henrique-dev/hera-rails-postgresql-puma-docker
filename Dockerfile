# Dockerfile development version
FROM ruby:3.1.0 AS hera-development

ARG USER_ID
ARG GROUP_ID
ARG TOKEN_GITHUB
ARG USER_GITHUB

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn redis

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY hera/ .
RUN rm -rf node_modules vendor
RUN gem install rails bundler
RUN bundle install
RUN chown -R user:user /opt/app
RUN mkdir -p tmp/pids
RUN touch tmp/pids/server.pid

USER $USER_ID
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]