require_relative '../test_helper'

class NomineesHelperTest < ActiveSupport::TestCase

  def helper
    @helper ||=
      begin
        obj = Object.new
        class << obj
          def session
            @session ||= {}
          end
        end
        obj.extend ApplicationHelper
        obj.extend NomineesHelper
        obj
      end
  end
  def nominee;       @nominee ||= Fabricate.build(:nominee); end
  def player;        @player ||= Fabricate(:player);         end
  def contest_years; [2013, 2014].sort;                      end
  def this_year;     contest_years.last;                     end
  def last_year;     contest_years.first;                    end

  setup do
    contest_years.each do |year|
      Fabricate(:category, year: year)
    end
  end

  def new_pick
    Fabricate.build(:pick, nominee: nominee)
  end

  def picks_editable(editable)
    helper.define_singleton_method(:picks_editable?) { editable }
  end

  def login(player)
    helper.define_singleton_method(:logged_in_player) { player }
  end

  def self.test_picks_to_show(desc, &block)
    test desc do
      config = instance_eval &block

      picks_editable config[:editable] if config.key?(:editable)
      login config[:login]

      picks_shown = helper.picks_to_show(config.fetch(:all_picks), config.fetch(:year))
      assert_equal config.fetch(:expected), picks_shown
    end
  end

  test_picks_to_show 'returns all picks if looking at previous year' do
    all_picks = 2.times.map { new_pick }
    {
      all_picks:  all_picks,
      year:       last_year,
      expected:   all_picks,
    }
  end

  test_picks_to_show 'returns all picks for current year if not editable' do
    all_picks = 2.times.map { new_pick }
    {
      all_picks:  all_picks,
      year:       this_year,
      editable:   false,
      expected:   all_picks,
    }
  end

  test_picks_to_show 'returns none if current contest year is editable and nobody logged in' do
    all_picks = 2.times.map { new_pick }
    {
      all_picks:  all_picks,
      year:       this_year,
      editable:   true,
      expected:   [],
    }
  end

  test_picks_to_show 'returns only only logged in player picks for editable current year' do
    own_pick = new_pick.tap do |pick|
      pick.entry.player = player
    end
    other_pick = new_pick
    {
      all_picks:  [own_pick, other_pick],
      year:       this_year,
      editable:   true,
      login:      player,
      expected:   [own_pick],
    }
  end

end
