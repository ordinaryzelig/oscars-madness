require 'test_helper'

class ContestByYearTest < ActionController::IntegrationTest

  def setup
    super
    @session = open_session
    Blueprints.announce_nominations(Date.today.year - 1)
    Blueprints.announce_nominations(Date.today.year)
  end

  test 'routing filters' do
    path = '/2010'
    get path
    assert_equal '2010', @controller.params[:contest_year]
    assert_equal path, root_path(:contest_year => 2010)
  end

  test 'selecting a year shows contest for that year alone' do
    last_year = Date.today.year - 1
    get root_path(:contest_year => last_year)
    assert_equal Category.for_year(last_year).all, assigns(:categories)
  end

  test 'root path shows this year' do
    get root_path
    assert_equal [Date.today.year], assigns(:categories).map(&:year).uniq
  end

end
