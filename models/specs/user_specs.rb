require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

require_relative("../user")
require_relative("../music_item")

class UserTest< MiniTest::Test

  def setup()
    @user = User.new(({'user_name'=>'Rainger FX', 'email_address'=> 'david@rainger.com', 'active_flag'=>true})
  end

  def test_user_buying()

  end

end
