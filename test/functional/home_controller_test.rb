require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  
  def test_index
    Blueprints.announce_nominations
    get :index
    assert_response :success
  end
  
end
