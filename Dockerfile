# syntax=docker/dockerfile:1
# check=error=true

# The site is plain files, so Jekyll runs on the build machine's own platform
# (no emulation) and only the nginx stage targets the server's.
ARG RUBY_VERSION=4.0.7
FROM --platform=$BUILDPLATFORM docker.io/library/ruby:$RUBY_VERSION-slim AS build

WORKDIR /site

# eventmachine and http_parser.rb (Jekyll's livereload) compile on install.
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV BUNDLE_WITHOUT="deploy" \
    JEKYLL_ENV="production"

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN bundle exec jekyll build --strict_front_matter


FROM docker.io/library/nginx:alpine

COPY config/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site/_site /usr/share/nginx/html
