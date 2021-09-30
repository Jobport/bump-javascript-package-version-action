FROM ruby:2.7.1-alpine3.11 as base
RUN apk --no-cache add git jq curl
RUN gem install gem-release
COPY labels /labels
COPY bump_version.rb /usr/bin/bump-version
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
