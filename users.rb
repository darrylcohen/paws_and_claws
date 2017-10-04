#New
get '/user/new' do
  erb :"users/new"
end

post '/user' do
  user = User.new
  user.name = params[:name]
  user.email = params[:email]
  user.password = params[:password]
  user.admin = params[:admin]
  user.save
  redirect '/users_maintenance'

end

#Read
get '/user/:id' do
  @user = User.find(params[:id])
  # @shelter_name = @user.shelter.name
  erb :"users/show"
end

#Update Edit
get '/user/:id/edit' do
  @user = User.find(params[:id])

  erb :"users/edit"
end

put '/user/:id' do
  user = User.find(params[:id])
  user.name = params[:name]
  user.email = params[:email]
  user.admin = params[:admin]
  user.save
  redirect '/users_maintenance'
end

#DELETE
delete '/user/:id' do
  user = User.find(params[:id])
  user.destroy
  redirect 'users_maintenance'
end
