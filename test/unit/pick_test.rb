require 'test_helper'

class PickTest < ActiveSupport::TestCase
  
  def test_points
    category = Category.make(:points => 1)
    pick = Pick.make(:category => category)
    assert_equal 0, pick.points
    pick.update_attributes! :correct => true
    assert_equal 1, pick.points
  end
  
end
