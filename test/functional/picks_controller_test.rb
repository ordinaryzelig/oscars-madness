require 'test_helper'

class PicksControllerTest < ActionController::TestCase
  
  def test_index
    Blueprints.announce_nominees
    player = Player.make
    get :index, :player_id => player.to_param
    assert_response :success
  end
  
  def test_edit
    Blueprints.announce_nominees
    player = Player.make
    get :edit, :player_id => player.to_param
    assert_response :success
  end
  
  def test_update
    Blueprints.announce_nominees
    player = Player.make
    pick = player.picks.first
    nominee = pick.category.nominees.first
    atts = {pick.id => {:nominee_id => nominee.id}}
    put :update, :player_id => player.to_param, :picks => atts
    assert_redirected_to player_picks_path(player)
    assert_equal nominee, pick.reload.nominee
  end
  
end
