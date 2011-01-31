require 'test_helper'

class EntriesControllerTest < ActionController::TestCase

  def setup
    super
    login_as_admin
    Blueprints.announce_nominations(Date.today.year - 1)
    Blueprints.announce_nominations(Date.today.year)
  end

  test 'list players and their entries' do
    player = Player.make
    player.entries.make :year => Date.today.year
    get :index
    assert_response :success
  end

  test 'create for player' do
    player = Player.make
    post :create, :year => Date.today.year, :player_id => player.to_param
    player.reload
    assert_equal Date.today.year, player.entries.first.year
  end

end
