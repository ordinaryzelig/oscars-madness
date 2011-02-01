require 'test_helper'

class PlayersControllerTest < ActionController::TestCase

  def setup
    super
    AdminConfig.make
  end

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

  def test_edit
    player = Player.make
    login_as player
    get :edit, :id => player.to_param
    assert_response :success
  end

  def test_update
    player = Player.make
    name_before = player.name
    password_changed_to = 'fdsa'
    login_as player
    put :update, :id => player.to_param, :player => {:name => player.name.reverse, :password => password_changed_to}
    assert_redirected_to player_edit_picks_path(player)
    player.reload
    assert_equal name_before.reverse, player.name
    assert_equal password_changed_to.digest, player.password
  end

  def test_new_for_admin_only
    player = Player.make
    login_as player
    get :new
    assert_redirected_to login_admin_path
  end

  def test_create_for_admin_only
    login_as Player.make
    post :create
    assert_redirected_to login_admin_path
  end

  def test_edit_requires_authentication
    get :edit, :id => 1
    assert_redirected_to login_path
  end

  def test_update_requires_authentication
    put :update, :id => 1
    assert_redirected_to login_path
  end

  def test_edit_allowed_for_admin_or_players_own_profile
    player = Player.make
    login_as player
    get :edit, :id => player.to_param
    assert_response :success
    login_as_admin
    get :edit, :id => player.to_param
    assert_response :success
  end

  def test_edit_for_another_player_redirects_to_own_edit
    player = Player.make
    login_as player
    get :edit, :id => 'asdf'
    assert_redirected_to edit_player_path(player)
  end

  def test_update_without_password_does_not_change_password
    player = Player.make
    login_as_admin
    new_name = player.name.reverse
    old_password = player.password
    put :update, :id => player.to_param, :player => {:name => new_name, :password => '', :password_confirmation => ''}
    assert_response :redirect
    assert_equal old_password, player.reload.password
    assert_equal new_name, player.reload.name
  end

end
