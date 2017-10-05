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
  redirect "/shelters_maintenance"

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
  binding.pry
  shelter.destroy
  # redirect 'shelters_maintenance'
  if !shelter.errors.full_messages.empty?
    # @clients = Client.where("shelter_id = ?",  session[:shelter_id] ).order("name ASC" )
    @shelters = Shelter.all.order("name ASC" )
    @message = shelter.errors.full_messages[0]
    erb :'shelters/maintenance'
  else
    redirect '/shelters_maintenance'
  end
end
