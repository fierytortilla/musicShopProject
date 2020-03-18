require("sinatra")
require('sinatra/contrib/all')
require('pry-byebug')

require_relative("models/category")
require_relative("models/user")
require_relative("models/music_item")
require_relative("models/purchase")
require_relative("models/inventory")
also_reload("models/*")

#items layer
get("/literally_music/items") do
  @inventories= Inventory.all()
  erb(:index)
end

get('/literally_music/items/:id') do
  @music_item= MusicItem.find_by_id(params[:id])
  erb(:show)
end

get('/literally_music/items/:id/edit') do
  @music_item= MusicItem.find_by_id(params[:id])
  erb(:edit)
end

post('/literally_music/items/:id') do
  @music_item= MusicItem.new(params)
  @music_item.update()
  erb(:update)
end

post('/literally_music/items/:id/delete') do
  @music_item= MusicItem.find_by_id(params[:id])
  @music_item.delete()
  erb(:destroy)
end


#USERS LAYER
get("/literally_music/users/index") do
  @users= User.all()
  erb(:index)
end

get("/literally_music/users/new") do
  erb(:new)
end

post("/literally_music") do
  @user= User.new(params)
  @user.save()
  erb(:create)
end



# get("/literally_music/items_on_sale") do
#   @music_items_on_sale= MusicItem.all_sale()
#   erb(:index)
# end

get("/literally_music/new-item") do
  erb(:new)
end

post('/literally_music') do
  @music_item = MusicItem.new(params)
  @music_item.save()
  erb(:create)
end

get("/literally_music/about_us") do
  erb(:about_us)
end
