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

end
