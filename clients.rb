get '/clients' do
  # @clients = Client.all
  @clients = Client.where("shelter_id = ?",  session[:shelter_id] ).order("name ASC" )

  if @clients.empty?
    @message = 'No Clients to Display'
  end
  store_route '/clients'

  erb :'clients/clients'
end

#New
get '/client/new' do
  @shelters = Shelter.all.order("name ASC" )
  erb :'clients/new'
end

post '/client' do
  client = Client.new
  client.name = params[:name]
  client.pic_image = params[:pic_image]
  client.phone = params[:phone]
  client.email = params[:email]
  client.shelter_id = params[:shelter_id]
  client.save
  redirect '/clients_maintenance'

end

#Read
get '/client/:id' do
  @client = Client.find(params[:id])
  @shelter_name = Shelter.find(@client.shelter_id).name
  # @shelter_name = @client.shelter.name
  erb :'clients/show'
end

#Update Edit
get '/client/:id/edit' do
  @client = Client.find(params[:id])
  @shelters = Shelter.all

  erb :'clients/edit'
end

put '/client/:id' do
  client = Client.find(params[:id])
  client.name = params[:name]
  client.pic_image = params[:pic_image]
  client.phone = params[:phone]
  client.email = params[:email]
  client.shelter_id = params[:shelter_id]
  client.save
  redirect '/clients'
end

#DELETE
delete '/client/:id' do
  client = Client.find(params[:id])
  client.destroy
  if !client.errors.full_messages.empty?
    @clients = Client.where("shelter_id = ?",  session[:shelter_id] ).order("name ASC" )
    @shelters = Shelter.all
    @message = client.errors.full_messages[0]
    erb :'clients/maintenance'
  else
    redirect '/clients_maintenance'
  end
end
