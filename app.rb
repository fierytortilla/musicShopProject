require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/music_item_controller')
require_relative('controllers/user_controller')

get('/literally_music') do
  erb(:home)
end

get('/literally_music/about_us') do
  erb(:about_us)
end
