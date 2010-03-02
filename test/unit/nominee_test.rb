require 'test_helper'

class NomineeTest < ActiveSupport::TestCase
  
  def test_declare_winner
    Blueprints.announce_nominees
    correct = Player.make
    wrong = Player.make
    category = Category.first
    winning_nominee = category.nominees.first
    losing_nominee = (category.nominees - [winning_nominee]).first
    correct_pick = correct.picks.for_category(category).first
    correct_pick.update_attributes! :nominee => winning_nominee
    wrong_pick = wrong.picks.for_category(category).first
    wrong_pick.update_attributes! :nominee => losing_nominee
    winning_nominee.declare_winner
    assert correct_pick.reload.correct
    assert !wrong_pick.reload.correct
  end
  
end
