get '/clients' do
  # @clients = Client.all
  @clients = Client.where("shelter_id = ?",  session[:shelter_id] )
  if @clients.empty?
    @message = 'No Animals to Display'
  end

  erb :'clients/clients'
end

#New
get '/client/new' do
  @shelters = Shelter.all
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
  redirect '/clients_maintenance'
end

#DELETE
delete '/client/:id' do
  client = Client.find(params[:id])
  client.destroy
  redirect 'clients_maintenance'
end
