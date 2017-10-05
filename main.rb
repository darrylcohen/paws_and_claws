# pg_dump -Fc --no-acl --no-owner -h localhost -U darrylcohen pawsclaws_db > db.dump
# https://github.com/darrylcohen/paws_and_claws/raw/master/db.dump
# heroku pg:backups:restore 'https://github.com/darrylcohen/paws_and_claws/raw/master/db.dump' DATABASE_URL


require 'sinatra'
# require 'sinatra/reloader'
# require_relative 'animal'
# require_relative 'client'
require 'pry'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/shelter'
require_relative 'models/user_shelter'
require_relative 'models/client'
require_relative 'models/animal'
require_relative 'clients'
require_relative 'animals'
require_relative 'users'
require_relative 'shelters'
require_relative 'user_access'

enable :sessions # sinatra provide this feature

helpers do

  def current_user
    User.find_by(id: session[:user_id]) # find only finds by id
  end

  def logged_in?
    !!current_user #will return true or false
    if current_user
      return true
    else
      return false
    end
  end

  def admin?
    User.find(session[:user_id]).admin == 'true'
  end

  def store_route route
    session[:previous_route] = route
  end
end

def user_access_unique? shelter_id, user_id
  UserShelter.where(shelter_id: shelter_id, user_id: user_id).length > 0 ? false : true
end

get '/' do
  redirect '/login'
end

get '/login' do
  @shelters = Shelter.all
  erb :login
end

get '/index' do
  session[:previous_route] = '/index'
  erb :index
end

post '/session' do
  # find user
  user = User.find_by(email: params[:email])

  # succesful create session then redirect
  if user && user.authenticate(params[:password])
    valid_user = UserShelter.where(shelter_id: params[:shelter_id], user_id: user.id)
    if valid_user.length == 0
      @message = "You are not a valid user for shelter #{Shelter.find(params[:shelter_id]).name}"
      @shelters = Shelter.all
      erb :login
    else
      session[:user_id] = user.id
      session[:shelter_id] = params[:shelter_id]
      redirect '/index'
    end
  else
    @message = 'Incorrect email or password'
    @shelters = Shelter.all
    erb :login #not redirect as want to keep variables
  end

end

put '/session_change' do
  session[:shelter_id] = params[:shelter_id]
  # binding.pry
  # request.path_info
  redirect session[:previous_route]

  # redirect '/animals'
  # redirect "/#{request.referer}"
end

delete '/session' do
  session[:user_id] = nil
  redirect '/login'
end

get '/adopt_animal/:id' do
  @animals = Animal.where("shelter_id = ? AND client_id is null",  session[:shelter_id])
  @client_id = params[:id]
  erb :adopt_animal
end

post '/adopt_an_animal' do
  animal_id = params[:animal_id]
  client_id = params[:client_id]
  animal = Animal.find(animal_id)
  animal.client_id = client_id
  animal.save
  redirect '/clients'
end

get '/return_animal/:id' do
  animal = Animal.find(params[:id] )
  animal.client_id = nil
  animal.shelter_id = session[:shelter_id]
  animal.save
  redirect '/clients'
end

# post '/return_an_animal' do
#   redirect '/animals'
# end

get '/animals_maintenance' do
  # @animals = Animal.all
  @animals = Animal.where("shelter_id = ?",  session[:shelter_id] ).order("name ASC" )
  @shelters = Shelter.all
  store_route '/animals_maintenance'
  erb :'animals/maintenance'
end

get '/clients_maintenance' do
  # @clients = Client.all
  @clients = Client.where("shelter_id = ?",  session[:shelter_id] ).order("name ASC" )

  @shelters = Shelter.all
  store_route '/clients_maintenance'
# 'sdfsdfsdfsdfsdf'
  erb :'clients/maintenance'
end

get '/users_maintenance' do
  @users = User.all.order("name ASC" )
  store_route '/users_maintenance'
  erb :"users/maintenance"
end

get '/shelters_maintenance' do
  @shelters = Shelter.all.order("name ASC" )
  store_route '/shelters_maintenance'
  erb :"shelters/maintenance"
end

get '/user_access_maintenance' do

  @users_access = UserShelter.all
  # @users = Users.all
  erb :"user_access/maintenance"
end
