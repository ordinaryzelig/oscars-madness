namespace :db do

  task :populate => :environment do
    require 'test/blueprints'
    Blueprints.announce_nominations(2010)
    Blueprints.announce_nominations
    3.times { Player.make }
  end

end
