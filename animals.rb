get '/animals' do
  # @animals = Animal.all
  # @animals = Animal.where("shelter_id = ?",  session[:shelter_id] ).order("name ASC" )
    @animals = Animal.where("shelter_id = ? AND client_id is null",  session[:shelter_id]).order("name ASC" )
  if @animals.empty?
    @message = 'No Animals to Display'
  end
  session[:previous_route] = '/animals'
  erb :'animals/animals'
end

#New
get '/animal/new' do
  @shelters = Shelter.all.order("name ASC" )
  erb :'animals/new'
end

post '/animal' do
  animal = Animal.new
  animal.name = params[:name]
  animal.pic_image = params[:pic_image]
  animal.age = params[:age]
  animal.species = params[:species]
  animal.shelter_id = params[:shelter_id]
  animal.save
  redirect '/animals_maintenance'
end

#REad
get '/animal/:id' do
  @animal = Animal.find(params[:id])
  # @shelter_name = Shelter.find(@animal.shelter_id).name
  @shelter_name = @animal.shelter.name
  erb :"animals/show"
end

#Update Edit
get '/animal/:id/edit' do
  @animal = Animal.find(params[:id])
  @shelters = Shelter.all
  erb :'animals/edit'
end

put '/animal/:id' do
  animal = Animal.find(params[:id])
  animal.name = params[:name]
  animal.pic_image = params[:pic_image]
  animal.age = params[:age]
  animal.species = params[:species]
  animal.shelter_id = params[:shelter_id]
  animal.save

  redirect '/animals_maintenance'
end

#DELETE
delete '/animal/:id' do
  animal = Animal.find(params[:id])
  animal.destroy
  redirect 'animals_maintenance'
end
