#New
get '/shelter/new' do
  erb :"shelters/new"
end

post '/shelter' do
  shelter = Shelter.new
  shelter.name = params[:name]
  shelter.address = params[:address]
  shelter.phone = params[:phone]
  shelter.save
  redirect "shelters/maintenance"

end

#Read
get '/shelter/:id' do
  @shelter = Shelter.find(params[:id])
  # @shelter_name = @shelter.shelter.name
  erb :"shelters/show"
end

#Update Edit
get '/shelter/:id/edit' do
  @shelter = Shelter.find(params[:id])

  erb :"shelters/edit"
end

put '/shelter/:id' do
  shelter = Shelter.find(params[:id])
  shelter.name = params[:name]
  shelter.address = params[:address]
  shelter.phone = params[:phone]
  shelter.save
  redirect '/shelters_maintenance'
end

#DELETE
delete '/shelter/:id' do
  shelter = Shelter.find(params[:id])
  shelter.destroy
  redirect 'shelters_maintenance'
end
