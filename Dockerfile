FROM ruby:2.1.7
MAINTAINER whe_green <whe_green@yahoo.co.id>

COPY . .

RUN bundle install 

# ENV RDS_HOSTNAME="billme-v0.ciag9ijvhpze.ap-southeast-1.rds.amazonaws.com"
# ENV RDS_DEVELOPMENT="billme-v0.ciag9ijvhpze.ap-southeast-1.rds.amazonaws.com"
# ENV RAILS_ENV="production"
 
# RUN bundle exec rake assets:precompile

# run server
EXPOSE 3000
CMD ["rails","server"]