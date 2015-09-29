source 'https://rubygems.org'
gem 'puma'
gem 'rack'

gem 'mysql2', '0.3.16'
gem 'activerecord', "~> 3.2.11", require: "active_record"

gem 'grape'
gem 'grape-entity'
gem 'grape-rabl'
gem 'grape-swagger'

group :spec, :development do
    gem 'pry', require: "pry"
end

group :spec do
    gem 'rack-test', require: 'rack/test'
    gem 'database_cleaner'
    gem 'factory_girl'
    gem 'webmock'
    gem 'delorean'
    # gem to time travel
    gem 'airborne'
    # gem to match json output.
end
