require 'pg'
require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'plantloversguide'
}

ActiveRecord::Base.establish_connection(options)