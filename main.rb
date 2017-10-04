
require 'sinatra'
require 'sinatra/reloader'
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
end

def user_access_unique? shelter_id, user_id
  User_shelter.where(shelter_id: shelter_id, user_id: user_id).length > 0 ? false : true
end

get '/' do
  redirect '/login'
end

get '/login' do
  @shelters = Shelter.all
  erb :login
end

post '/session' do
  # find user
  user = User.find_by(email: params[:email])

  # succesful create session then redirect
  if user && user.authenticate(params[:password])
    valid_user = User_shelter.where(shelter_id: params[:shelter_id], user_id: user.id)
    if valid_user.length == 0
      @message = "You are not a valid user for shelter #{Shelter.find(params[:shelter_id]).name}"
      @shelters = Shelter.all
      erb :login
    else
      session[:user_id] = user.id
      session[:shelter_id] = params[:shelter_id]
      erb :landing
    end
  else
    @message = 'Incorrect email or password'
    @shelters = Shelter.all
    erb :login #not redirect as want to keep variables
  end

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
  animal.save
  redirect '/clients'
end

# post '/return_an_animal' do
#   redirect '/animals'
# end

get '/animals_maintenance' do
  @animals = Animal.all
  @shelters = Shelter.all

  erb :'animals/maintenance'
end

get '/clients_maintenance' do
  @clients = Client.all
  @shelters = Shelter.all

  erb :'clients/maintenance'
end

get '/users_maintenance' do
  @users = User.all
  erb :"users/maintenance"
end

get '/shelters_maintenance' do
  @shelters = Shelter.all
  erb :"shelters/maintenance"
end

get '/user_access_maintenance' do

  @users_access = User_shelter.all
  # @users = Users.all
  erb :"user_access/maintenance"
end
