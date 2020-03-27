require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

require_relative("../user")
require_relative("../music_item")
require_relative("../category")

class UserTest< MiniTest::Test

  def setup()
    @category = Category.new({'category_name'=>'synthesizers'})
    @category.save()
    @user = User.new({'user_name'=>'Rainger FX', 'email_address'=> 'david@rainger.com'})
    @user.save()
    @user2= User.new({'user_name'=>'Maria Chavez', 'email_address'=> 'mariachavez@ordinaryperson.com'})
    @user2.save()
    @item1 = MusicItem.new({'item_name'=>'Casio Keytar', 'buying_cost'=> 50.00, 'selling_price'=> 69.00, 'category_id'=>@category.id, 'bought_flag'=> false, 'user_id'=>@user.id})
    @item1.save()
  end

  def test_user_selling_items()
    items_for_sale= @user.get_users_items_for_sale();
    assert_equal(@item1.item_name, items_for_sale[0].item_name)
    assert_equal(@item1.buying_cost, items_for_sale[0].buying_cost)
    assert_equal(@user.id, items_for_sale[0].user_id)
  end

  def test_users_items_for_sale()
    items_for_sale= @user.get_users_items_for_sale()
    assert_equal(1, items_for_sale.length)
  end

  def test_users_purchased_items()
    purchased_items= @user2.get_users_purchased_items()
    assert_equal(0, purchased_items.length)
  end

  def test_user_buying_item()
    @item1.bought_flag= true
    @item1.user_id= @user2.id
    @item1.update()
    purchased_items_updated= @user2.get_users_purchased_items()
    assert_equal(1, purchased_items_updated.length)
  end

end
