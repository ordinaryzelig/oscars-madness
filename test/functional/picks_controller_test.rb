require 'test_helper'

class PicksControllerTest < ActionController::TestCase
  
  def test_index
    Blueprints.announce_nominees
    player = Player.make
    login_as player
    get :index, :player_id => player.to_param
    assert_response :success
  end
  
  def test_edit
    Blueprints.announce_nominees
    player = Player.make
    login_as player
    get :edit, :player_id => player.to_param
    assert_response :success
  end
  
  def test_update
    Blueprints.announce_nominees
    player = Player.make
    login_as player
    pick = player.picks.first
    nominee = pick.category.nominees.first
    atts = {pick.id => {:nominee_id => nominee.id}}
    put :update, :player_id => player.to_param, :picks => atts
    assert_redirected_to player_picks_path(player)
    assert_equal nominee, pick.reload.nominee
  end
  
  def test_edit_redirects_when_picks_not_editable
    AdminConfig.make(:picks_editable => false)
    login_as Player.make
    get :edit, :player_id => Player.make
    assert_redirected_to root_path
  end
  
  def test_update_redirects_when_picks_not_editable
    AdminConfig.make(:picks_editable => false)
    login_as Player.make
    pick = Pick.make
    nominee_id_before = pick.nominee_id
    get :update, :player_id => Player.make, :picks => {pick.id => {:nominee_id => pick.nominee_id + 1}}
    assert_redirected_to root_path
    assert_equal nominee_id_before, pick.reload.nominee_id
  end
  
  # only player can see own picks or admin can see picks.
  def test_index_redirects_when_picks_not_editable_and_player_not_looking_at_own_picks_and_not_logged_in_as_admin
    AdminConfig.make(:picks_editable => false)
    login_as Player.make
    get :index, :player_id => Player.make.id
    assert_redirected_to root_path
  end
  
  def test_admin_can_get_to_edit
    Blueprints.announce_nominees
    player = Player.make
    login_as_admin
    get :edit, :player_id => player.to_param
    assert_response :success
  end
  
  def test_admin_can_update
    Blueprints.announce_nominees
    player = Player.make
    login_as_admin
    put :update, :player_id => player.to_param, :picks => {}
    assert_redirected_to player_picks_path(player)
  end
  
  def test_admin_can_see_picks
    Blueprints.announce_nominees
    player = Player.make
    login_as_admin
    get :index, :player_id => player.to_param
    assert_response :success
  end
  
end
