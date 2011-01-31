require 'test_helper'

class EntryTest < ActiveSupport::TestCase

  def test_after_create_creates_picks
    Blueprints.announce_nominations
    entry = Entry.make
    assert_equal Category.all.size, entry.picks.size
  end

  def test_points
    Blueprints.announce_nominations
    entry = Entry.make
    entry.picks.each { |pick| pick.update_attributes! :correct => true }
    assert_equal 8, entry.points
  end

  def test_picks_attributes_equals
    Blueprints.announce_nominations
    entry = Entry.make
    picks_attributes = entry.picks.inject({}) do |atts, pick|
      atts[pick.id] = {:nominee_id => pick.category.nominees.first.id}
      atts
    end
    entry.picks_attributes = picks_attributes
    entry.save!
    entry.reload.picks.each do |pick|
      assert_equal picks_attributes[pick.id][:nominee_id], pick.nominee_id
    end
  end

end
