require_relative '../test_helper'

class PlayerTest < ActiveSupport::TestCase

  def test_authenticate
    password = 'asdf'
    player = Fabricate(:player, :password => password.digest)
    assert_equal player, Player.authenticate(player.name, password)
  end

  def test_authenticate_case_insensitive
    name = 'asdf'
    password = 'asdf'
    player = Fabricate(:player, :name => name, :password => password.digest)
    assert_equal player, Player.authenticate(name.upcase, password)
  end

  test 'find by omniauth finds player and updates image' do
    player = Fabricate(:player, :uid => 123, :provider => 'facebook')
    omniauth = {
      'provider' => 'facebook',
      'uid'      => 123,
      'info' => {
        'image' => 'gravatar.com',
      },
    }
    found_player = Player.find_or_create_by_omniauth(omniauth)

    assert_equal player, found_player
    assert_equal omniauth['info']['image'], found_player.facebook_image_url
  end

  test 'create by omniauth' do
    omniauth = {
      'provider' => 'facebook',
      'uid' => 123,
      'info' => {
        'name' => 'asdf',
        'image' => 'gravatar.com/asdf',
      },
    }
    player = Player.find_or_create_by_omniauth(omniauth)
    assert_equal omniauth['provider'], player.provider
    assert_equal omniauth['uid'], player.uid.to_i
    assert_equal omniauth['info']['name'], player.name
    assert_equal omniauth['info']['image'], player.facebook_image_url
  end

end
