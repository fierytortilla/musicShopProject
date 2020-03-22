require("sinatra")
require('sinatra/contrib/all')
require('pry-byebug')

require_relative("../models/category")
require_relative("../models/user")
require_relative("../models/music_item")
also_reload("../models/*")


#USERS LAYER
get("/literally_music/users") do
  @users= User.all()
  erb(:"users/index")
end

get("/literally_music/users/new") do
  erb(:"users/new")
end

get('/literally_music/users/:id') do
  @user= User.find_by_id(params[:id])
  @music_items_purchased= @user.get_users_purchased_items()
  @music_items_sale= @user.get_users_items_for_sale()
  erb(:"users/show")
end

get("/literally_music/users/:id/buy") do
  @user= User.find_by_id(params[:id])
  @music_items= MusicItem.all_on_sale()
  erb(:"items/index_items_sale")
end

post("/literally_music/users/:id/buy/:id2") do
  @music_item= MusicItem.find_by_id(params[:id2])
  @music_item.bought_flag= true
  @music_item.user_id= params[:id]
  @music_item.update()
  @user= User.find_by_id(params[:id])
  @music_items_sale= @user.get_users_items_for_sale()
  @music_items_purchased= @user.get_users_purchased_items()
  erb(:"users/show")
end

post("/literally_music/users/:id/delete") do
  @user= User.find_by_id(params[:id])
  @user.delete()
  redirect(:"literally_music/users")
end

get("/literally_music/users/:id/edit") do
  @user = User.find_by_id(params[:id])
  erb(:"users/edit")
end

post('/literally_music/users/:id') do
  @user= User.new(params)
  @user.update()
  redirect(:"/literally_music/users")
  #erb(:"users/update")
end

post("/literally_music/users") do
  @user= User.new(params)
  @user.save()
  redirect(:"/literally_music/users")
end
