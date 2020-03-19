require("sinatra")
require('sinatra/contrib/all')
require('pry-byebug')

require_relative("models/category")
require_relative("models/user")
require_relative("models/music_item")
also_reload("models/*")


#USERS LAYER
get("/literally_music/users") do
  @users= User.all()
  erb(:index_users)
end

get('/literally_music/users/:id') do
  @user= User.find_by_id(params[:id])
  @music_items_purchased= @user.get_users_purchased_items()
  @music_items_sale= @user.get_users_items_for_sale()
  erb(:show_user)
end

get("/literally_music/users/:id/buy") do
  @user= User.find_by_id(params[:id])
  @music_items= MusicItem.all_on_sale()
  erb(:index_items_sale)
  #redirect('/literally_music/users/:id')
end

post("/literally_music/users/:id/buy/:id2") do
  @music_item= MusicItem.find_by_id(params[:id2])
  @music_item.bought_flag= true
  @music_item.user_id= params[:id]
  @music_item.update()
  redirect ("/literally_music/users/:id")
end

# post("/literally_music/users/:id/edit/:id2") do
#   @music_item= MusicItem.find_by_id(params[:id2])
#   @music_item.bought_flag= true
#   @music_item.user_id= params[:id]
#   @music_item.update()
#   redirect ("/literally_music/users/:id")
# end

get("/literally_music/users/new") do
  erb(:new)
end

post("/literally_music/users") do
  @user= User.new(params)
  @user.save()
  erb(:create)
end
