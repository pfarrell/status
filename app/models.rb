require 'sequel'
require 'logger'
  
$console = ENV['RACK_ENV'] == 'development' ? Logger.new(STDOUT) : nil
DB = Sequel.connect(
  ENV['STATUS_DB'] || 'postgres://localhost/status',
  logger: $console,
  test: true
)

DB.sql_log_level = :debug
DB.extension(:pagination)
DB.extension(:pg_array, :pg_json)
DB.extension(:connection_validator)

Sequel::Model.plugin :timestamps
Sequel::Model.plugin :json_serializer

require 'models/group'
require 'models/entry'
require 'models/status'
