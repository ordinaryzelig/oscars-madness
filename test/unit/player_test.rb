require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  
  def test_after_create_creates_picks
    Blueprints.announce_nominees
    player = Player.make
    assert_equal Category.all.size, player.picks.size
  end
  
  def test_points
    Blueprints.announce_nominees
    player = Player.make
    player.picks.each { |pick| pick.update_attributes! :correct => true }
    assert_equal 8, player.points
  end
  
  def test_picks_attributes_equals
    Blueprints.announce_nominees
    player = Player.make
    picks_attributes = player.picks.inject({}) do |atts, pick|
      atts[pick.id] = {:nominee_id => pick.category.nominees.first.id}
      atts
    end
    player.picks_attributes = picks_attributes
    player.save!
    player.reload.picks.each do |pick|
      assert_equal picks_attributes[pick.id][:nominee_id], pick.nominee_id
    end
  end
  
  def test_hash_password
    password = 'asdf'
    player = Player.make_unsaved(:password => password, :password_confirmation => password)
    player.save!
    assert_equal password.digest, player.reload.password
  end
  
end
