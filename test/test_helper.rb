ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/pride'

require_relative 'database_cleaner'
require_relative 'fabrication'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  def announce_nominations(year = Date.today.year)
    Fabricate(:admin_config, :admin_password => 'fdsa'.digest, :picks_editable => true)

    categories = ['best actor', 'best actress', 'best director'].map do
      Fabricate(:category, :year => year)
    end
    categories << Fabricate(:best_picture)

    films = 3.times.map { |idx| Fabricate(:film, name: "Karate Kid #{idx + 1}") }

    categories.each do |cat|
      films.each do |film|
        Fabricate(:nominee, :film => film, category: cat)
      end
    end
  end
end
