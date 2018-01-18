require 'sinatra'
# require 'sinatra/reloader'

require_relative 'db_config'

require_relative 'models/comment'
require_relative 'models/plant'
require_relative 'models/user'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end

# routes

get '/' do
  @plants = Plant.all
  erb :index
end

get '/users/new' do 
  erb :create
end

post '/users' do
  user = User.new
  user.name = params[:name]
  user.email = params[:email]
  user.password = params[:password]
  user.save
  session[:user_id] = user.id
  redirect '/'
end

get '/session/new' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:email])

  if user && user.authenticate(params[:password])

    session[:user_id] = user.id
    redirect '/'
  else
    erb :login
  end  
end

delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

get '/plants/new' do
  redirect '/session/new' unless logged_in?
  erb :new
end

get '/plants/:id' do
  redirect '/session/new' unless logged_in?    
  @plant = Plant.find(params[:id])
  @comments = Comment.where(plant_id: @plant.id)
  erb :show
end

get '/plants/:id/edit' do
  @plant = Plant.find(params[:id])
  @comments = Comment.where(plant_id: @plant.id)
  erb :edit
end

post '/plants' do
  plant = Plant.new
  plant.name = params[:name]
  plant.image_url = params[:image_url]
  plant.user = current_user
  plant.save  
  redirect '/'
end

delete '/plants/:id' do
  plant = Plant.find(params[:id])
  plant.destroy
  redirect '/'
end

put '/plants/:id' do
  plant = Plant.find(params[:id])
  plant.name = params[:name]
  plant.image_url = params[:image_url]
  plant.save
  redirect "/plants/#{params[:id]}"
end
  
post '/comments' do 
  comment = Comment.new
  comment.body = params[:body]
  comment.plant_id = params[:plant_id]
  comment.user = current_user
  comment.save
  redirect "/plants/#{comment.plant_id}"
end

get '/my_plants' do
  @plants = current_user.plants
  erb :my_plants
end





