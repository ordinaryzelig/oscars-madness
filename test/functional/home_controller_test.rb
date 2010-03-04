require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  def test_index
    Blueprints.announce_nominees
    get :index
    assert_response :success
  end
  
end
