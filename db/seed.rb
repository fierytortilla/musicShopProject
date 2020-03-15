require_relative("../models/music_item")
require_relative("../models/user")

MusicItem.delete_all()
User.delete_all()
Categories.delete_all()

category1 = Category.new({'name'=>'guitars'})
category2 = Category.new({'name'=>'bass'})
category3 = Category.new({'name'=>'drums'})
category4 = Category.new({'name'=>'effect pedals'})
category5 = Category.new({'name'=>'keyboards'})

category1.save()
category2.save()
category3.save()
category4.save()

user1= User.new({'name'=>'John Smith','email_address'=> 'johnsmith@ordinaryman.com'})

user2= User.new({'name'=>'Maria Chavez', 'email_address'=> 'mariachavez@ordinaryman.com'})

user1.save()
user2.save()

item1 = Item.new({'item_name'=>'Casio Keytar', 'buying_cost'=> 50.00, 'selling_cost'=> 69.00, 'category_id'=>category5.id})

item2 = Item.new({'item_name'=>'Fender Jazzmaster', 'buying_cost'=> 500.00, 'selling_cost'=> 720.00, 'category_id'=>category1.id}) 
