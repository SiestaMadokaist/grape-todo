module Application
    $:.unshift File.dirname(__FILE__)
    env = ENV["RACK_ENV"] || :development
    require 'bundler'
    Bundler.require(:default, env)

    include( ActiveSupport::Configurable )
    configure do |config|
        config.root = File.dirname(__FILE__)
        config.env = ActiveSupport::StringInquirer.new(env.to_s)
    end
    db_config = YAML.load(ERB.new(File.read("config/database.yml")).result)[Application.config.env]
    ActiveRecord::Base.default_timezone = :utc
    ActiveRecord::Base.establish_connection(db_config)
    ActiveRecord::Base.include_root_in_json = false
end


