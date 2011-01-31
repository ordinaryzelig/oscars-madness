require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  def test_index
    Blueprints.announce_nominations
    3.times do
      entry = Entry.make
      3.times { entry.picks.make }
    end
    get :index
    assert_response :success
  end

end
