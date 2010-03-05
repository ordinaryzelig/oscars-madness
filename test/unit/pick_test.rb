require 'test_helper'

class PickTest < ActiveSupport::TestCase
  
  def test_points
    category = Category.make(:points => 1)
    pick = Pick.make(:category => category)
    assert_equal 0, pick.points
    pick.update_attributes! :correct => true
    assert_equal 1, pick.points
  end
  
  def test_named_scope_picked
    Blueprints.announce_nominations
    player = Player.make
    assert_equal 0, player.picks.picked.size
    player.picks.each { |p| p.update_attributes! :nominee => p.category.nominees.first }
    assert_equal player.picks.size, player.picks.picked.size
  end
  
end
