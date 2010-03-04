require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  
  def test_new
    login_as_admin
    get :new
    assert_response :success
  end
  
  def test_create
    login_as_admin
    player = Player.make_unsaved
    post :create, :player => player.attributes
    player = Player.find_by_name(player.name)
    assert_redirected_to player_edit_picks_path(player)
  end
  
end
