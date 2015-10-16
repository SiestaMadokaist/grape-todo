FROM heroku/ruby
MAINTAINER whe_green <whe_green@yahoo.co.id>

RUN bundle install

ENV RACK_ENV="production"

ENV TODO_DB_PRODUCTION="d7257hhr1s3mpe"
ENV TODO_USER_PRODUCTION="uqlubleyvmvfig"
ENV TODO_PASS_PRODUCTION="V07ddfFI2DbfFswB-ibNfSd9lB"
