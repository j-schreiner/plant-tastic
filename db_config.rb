require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'plants_db'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)