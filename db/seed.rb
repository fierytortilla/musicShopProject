require_relative("../models/music_item")
require_relative("../models/user")
require_relative("../models/category")
require_relative("../models/inventory")
require_relative("../models/purchase")
require("pry-byebug")

MusicItem.delete_all()
User.delete_all()
Category.delete_all()
Inventory.delete_all()
Purchase.delete_all()

category1 = Category.new({'category_name'=>'guitars'})
category2 = Category.new({'category_name'=>'bass'})
category3 = Category.new({'category_name'=>'drums'})
category4 = Category.new({'category_name'=>'effect pedals'})
category5 = Category.new({'category_name'=>'synthesizers'})
category6 = Category.new({'category_name'=>'accessories'})


category1.save()
category2.save()
category3.save()
category4.save()
category5.save()
category6.save()

#binding.pry()

user1= User.new({'user_name'=>'John Smith','email_address'=> 'johnsmith@ordinaryman.com', 'active_flag'=>true})

user2= User.new({'user_name'=>'Maria Chavez', 'email_address'=> 'mariachavez@ordinaryman.com', 'active_flag'=>true})

user1.save()
user2.save()

item1 = MusicItem.new({'item_name'=>'Casio Keytar', 'buying_cost'=> 50.00, 'selling_price'=> 69.00, 'category_id'=>category5.id})

item2 = MusicItem.new({'item_name'=>'Fender Jazzmaster', 'buying_cost'=> 500.00, 'selling_price'=> 720.00, 'category_id'=>category1.id})

item3 = MusicItem.new({'item_name'=>'Bastl Thyme Synthesizer', 'buying_cost'=> 300.00, 'selling_price'=> 500.00, 'category_id'=>category5.id})

item4 = MusicItem.new({'item_name'=>'1/4" TS guitar lead', 'buying_cost'=> 1.00, 'selling_price'=> 10.00, 'category_id'=>category6.id})

item1.save()
item2.save()
item3.save()
item4.save()

inventory1= Inventory.new({'bought_flag'=>false, 'selling_item_id'=> item1.id, 'seller_user_id'=>user1.id})

inventory2= Inventory.new({'bought_flag'=>false, 'selling_item_id'=> item2.id, 'seller_user_id'=>user2.id})

inventory3= Inventory.new({'bought_flag'=>false, 'selling_item_id'=> item3.id, 'seller_user_id'=>user2.id})

inventory4= Inventory.new({'bought_flag'=>false, 'selling_item_id'=> item4.id, 'seller_user_id'=>user2.id})

inventory1.save()
inventory2.save()
inventory3.save()
inventory4.save()

purchase1= Inventory.item_gets_purchased(user1, user2, item1)
purchase1.save()

binding.pry()

nil
