class Entry < ActiveRecord::Base

  include Enumerable

  belongs_to :player
  has_many :picks, :dependent => :destroy

  after_create :generate_picks

  scope :for_year, ->(year) { where(:year => year) }

  def points
    picks.map(&:points).sum
  end

  def picks_attributes=(atts)
    atts.each do |pick_id, att|
      picks.detect { |pick| pick.id == pick_id.to_i }.update_attributes! :nominee_id => att[:nominee_id]
    end
  end

  def <=>(another_entry)
    if another_entry.points == points
      if another_entry.picks.correct.size == picks.correct.size
        player.name.downcase <=> another_entry.player.name.downcase
      else
        another_entry.picks.correct.size <=> picks.correct.size
      end
    else
      another_entry.points <=> points
    end
  end

  private

  def generate_picks
    Category.for_year(year).each { |cat| picks.create!(:category => cat) }
  end

end
