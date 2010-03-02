require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def test_after_create_creates_picks
    Blueprints.announce_nominees
    player = Player.make
    assert_equal Category.all.size, player.picks.size
  end
  
  def test_points
    Blueprints.announce_nominees
    Category.first.update_attributes! :points => 5
    player = Player.make
    player.picks.each { |pick| pick.update_attributes! :correct => true }
    assert_equal 7, player.points
  end
  
end
