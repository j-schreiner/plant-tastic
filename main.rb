require 'pry'     
require 'sinatra'
require 'sinatra/reloader'

require_relative 'db_config'


get '/' do
  erb :index
end





