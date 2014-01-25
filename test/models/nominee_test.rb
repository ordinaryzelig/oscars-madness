require_relative '../test_helper'

class NomineeTest < ActiveSupport::TestCase

  def test_declare_winner
    announce_nominations

    correct         = Fabricate(:entry)
    wrong           = Fabricate(:entry)
    category        = Category.first
    winning_nominee = category.nominees.first
    losing_nominee  = (category.nominees - [winning_nominee]).first

    correct_pick    = correct.picks.for_category(category).first
    correct_pick.update_attributes! :nominee => winning_nominee
    wrong_pick      = wrong.picks.for_category(category).first
    wrong_pick.update_attributes! :nominee => losing_nominee

    winning_nominee.declare_winner
    assert winning_nominee.is_winner
    assert correct_pick.reload.correct
    assert !wrong_pick.reload.correct
  end

  test 'create with film name' do
    film = Fabricate(:film)
    nominee = Fabricate.build(:nominee, film: nil, name: 'nomination')
    nominee.film_name = film.name
    nominee.save!
    assert_equal film, nominee.film
  end

  test 'create with category name' do
    category = Fabricate(:category)
    nominee = Fabricate.build(
      :nominee,
      name:      'nomination',
      film:      Fabricate(:film),
      category:  nil,
    )
    nominee.category_name = category.name
    nominee.save!
    assert_equal category, nominee.category
  end

end
