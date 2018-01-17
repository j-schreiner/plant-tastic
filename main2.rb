require 'sinatra'
require 'sinatra/reloader'

require_relative 'db_config'

require_relative 'models/plant'
require_relative 'models/comment'
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

get '/' do
  @plants = Plant.all
  erb :index
end

get '/plants/new' do
  erb :new
end

get '/plants/:id' do
  redirect '/login' unless logged_in?
    
  @plant = Plant.find(params[:id])
  @comments = Comment.where(plant_id: @plant.id)
  erb :show
end

get '/plants/:id/edit' do
  @plant = Plant.find(params[:id])
  erb :edit
end

post '/plants' do
  plant = Plant.new
  plant.name = params[:name]
  plant.image_url = params[:image_url]
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
  comment.save
  redirect "/plants/#{comment.plant_id}"
end

get '/login' do
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
  redirect '/login'
end

