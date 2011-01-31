require 'test_helper'

class PickTest < ActiveSupport::TestCase

  def test_points
    category = Category.make(:points => 1)
    pick = Pick.make(:category => category)
    assert_equal 0, pick.points
    pick.update_attributes! :correct => true
    assert_equal 1, pick.points
  end

  def test_named_scope_picked
    Blueprints.announce_nominations
    entry = Entry.make
    assert_equal 0, entry.picks.picked.size
    entry.picks.each { |p| p.update_attributes! :nominee => p.category.nominees.first }
    assert_equal entry.picks.size, entry.picks.picked.size
  end

end
