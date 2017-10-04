#New
get '/user_access/new' do
  @users = User.all
  @shelters = Shelter.all
  erb :"user_access/new"
end

post '/user_access' do
  user_access = User_shelter.new
  user_access.shelter_id = params[:shelter_id]
  user_access.user_id = params[:user_id]
  if user_access_unique? user_access.shelter_id, user_access.user_id
    user_access.save
  else
    @message = "User already has access to Shelter "
  end
  # @users = User.all
  # @shelters = Shelter.all
  @users_access = User_shelter.all
  @users = User.all
  @shelters = Shelter.all

  # erb :"user_access/maintenance"
  erb :"user_access/new"

end

#Read
# get '/user_access/:id' do
#   @user_access = user_access.find(params[:id])
#   # @shelter_name = @user_access.shelter.name
#   erb :"user_accesss/show"
# end

#Update Edit
get '/user_access/:id/edit' do
  @user_access = User_shelter.find(params[:id])
  @user = User.find(@user_access.user_id)
  @shelters = Shelter.all
  erb :"user_access/edit"
end

put '/user_access/:id' do
  user_access = User_shelter.find(params[:id])

  user_access.shelter_id = params[:shelter_id]
  user_access.user_id = params[:user_id]

  if user_access_unique? user_access.shelter_id, user_access.user_id
    user_access.save
      @users_access = User_shelter.all
    redirect '/user_access_maintenance'
  else
    @message = "User #{User.find(user_id).name} already has access to Shelter #{Shelter.find(shelter_id).name}"
    @users = User.all
    @shelters = Shelter.all
    erb :"user_access/edit"

  end


end

#DELETE
delete '/user_access/:id' do
  user_access = User_shelter.find(params[:id])
  user_access.destroy
  redirect '/user_access_maintenance'
end
