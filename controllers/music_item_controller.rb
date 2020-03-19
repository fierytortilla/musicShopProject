require("sinatra")
require('sinatra/contrib/all')
require('pry-byebug')

require_relative("../models/category")
require_relative("../models/user")
require_relative("../models/music_item")
also_reload("../models/*")

#items layer
get("/literally_music/items") do
  @music_items= MusicItem.all()
  erb(:"items/index")
end

get("/literally_music/items/new") do
  @users= User.all()
  @categories= Category.all()
  erb(:"item/new")
end

get('/literally_music/items/:id') do
  binding.pry()
  @music_item= MusicItem.find_by_id(params[:id])
  erb(:show_item)
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
  redirect ("/literally_music/items")
end

post('/literally_music/items') do
  @music_item = MusicItem.new(params)
  @music_item.save()
  erb(:create)
end
