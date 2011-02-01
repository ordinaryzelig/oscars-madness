require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  def test_hash_password
    password = 'asdf'
    player = Player.make_unsaved(:password => password, :password_confirmation => password)
    player.save!
    assert_equal password.digest, player.reload.password
  end

  def test_authenticate
    password = 'asdf'
    player = Player.make(:password => password)
    assert_equal player, Player.authenticate(player.name, password)
  end

  def test_authenticate_case_insensitive
    name = 'asdf'
    password = 'asdf'
    player = Player.make(:name => name, :password => password)
    assert_equal player, Player.authenticate(name.upcase, password)
  end

  def test_unique_name_case_insensitive
    name = 'asdf'
    player = Player.make(:name => name)
    another_player = Player.make_unsaved(:name => name.upcase)
    assert !another_player.valid?
    assert another_player.update_attributes(:name => name.reverse)
  end

  test 'find by omniauth' do
    player = Player.make(:uid => 123, :provider => 'facebook')
    assert_equal Player.find_or_create_by_omniauth('provider' => 'facebook', 'uid' => 123), player
  end

  test 'create by omniauth' do
    omniauth = {'provider' => 'facebook', 'uid' => 123, 'user_info' => {'name' => 'asdf'}}
    player = Player.find_or_create_by_omniauth(omniauth)
    assert_equal omniauth['provider'], player.provider
    assert_equal omniauth['uid'], player.uid
    assert_equal omniauth['user_info']['name'], player.name
  end

end
