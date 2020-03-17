require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

require_relative("../user")

class UserTest< MiniTest::Test

  def setup()

  end

  def test_user_buying()

  end

end
