FROM whegreen/grape-todo-env
MAINTAINER whe_green <whe_green@yahoo.co.id>

COPY . .

RUN bundle install 

ENV RACK_ENV="production"

ENV TODO_DB_PRODUCTION="d7257hhr1s3mpe"
ENV TODO_USER_PRODUCTION="uqlubleyvmvfig"
ENV TODO_PASS_PRODUCTION="V07ddfFI2DbfFswB-ibNfSd9lB"
ENV TODO_HOST_PRODUCTION="ec2-54-83-51-38.compute-1.amazonaws.com"
ENV TODO_DB_PORT="5432"
 
# RUN bundle exec rake assets:precompile

# run server
EXPOSE 9292
CMD ["puma"]