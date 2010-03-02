require 'machinist/active_record'
require 'sham'
blueprints_dir = Rails.root + 'test/blueprints'
Dir.entries(blueprints_dir).reject { |entry| entry =~ /^\./ }.each do |entry|
  require "#{blueprints_dir}/#{entry}"
end

module Blueprints
  
  def self.announce_nominees
    categories = 3.times.map { Category.make }
    categories << Category.make(:best_picture)
    films = 3.times.map { Film.make }
    categories.each do |cat|
      films.each do |film|
        cat.nominees.make(:film => film)
      end
    end
  end
  
end
