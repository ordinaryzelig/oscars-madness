require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def test_new
    get :new
    assert_response :success
  end
  
  def test_create
    player = Player.make
    post :create, :player => {:name => player.name, :password => 'asdf'}
    assert_redirected_to player_edit_picks_path(player)
    assert_equal player.id, @request.session[:player_id]
  end
  
  def test_destroy
    login_as Player.make
    get :destroy
    assert_nil @request.session[:player_id]
  end
  
  def test_failed_login_lets_player_try_again
    post :create, :player => {}
    assert_nil @request.session[:player_id]
    assert flash[:error]
    assert_redirected_to login_path
  end
  
  def test_new_admin
    get :new_admin
    assert_response :success
  end
  
  def test_create_admin
    AdminConfig.make
    post :create_admin, :player => {:password => 'fdsa'}
    assert session[:admin_logged_in]
    assert_redirected_to root_path
  end
  
end
