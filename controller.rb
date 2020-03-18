require("sinatra")
require('sinatra/contrib/all')
require('pry-byebug')

require_relative("models/category")
require_relative("models/user")
require_relative("models/music_item")
require_relative("models/purchase")
require_relative("models/inventory")
also_reload("models/*")

# get("/literally_music") do
#
# end

get("/literally_music") do
  @inventories= Inventory.all()
  erb(:index)
end

get('/literally_music/:id') do
  @music_item= MusicItem.find_by_id(params[:id])
  erb(:show)
end

get('/literally_music/:id/edit') do
  @music_item= MusicItem.find_by_id(params[:id])
  erb(:edit)
end

post('/literally_music/:id') do
  @music_item= MusicItem.new(params)
  @music_item.update()
  erb(:update)
end

post('/literally_music/:id/delete') do
  @music_item= MusicItem.find_by_id(params[:id])
  @music_item.delete()
  erb(:destroy)
end

# get("/literally_music/index") do
#   @users= User.all()
#   erb(:index)
# end

get("/literally_music/new-user") do
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
