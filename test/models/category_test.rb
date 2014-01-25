require_relative '../test_helper'

class CategoryTest < ActiveSupport::TestCase

  def test_has_winner?
    nominee = Fabricate(:nominee)
    category = nominee.category
    assert !category.has_winner?
    nominee.declare_winner
    assert category.reload.has_winner?
  end

end
