require File.expand_path('../application', __FILE__)
use ActiveRecord::ConnectionAdapters::ConnectionManagement
use ActiveRecord::QueryCache
use Rack::Deflater
# use Rack::Attack
use ActiveRecord::ConnectionAdapters::ConnectionManagement
#
# # start new relic agent
# NewRelic::Agent.manual_start
#
run ApplicationServer
