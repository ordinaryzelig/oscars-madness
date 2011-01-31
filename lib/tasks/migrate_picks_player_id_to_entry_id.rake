namespace :db do

  task :migrate_picks_player_id_to_entry_id => :environment do
    Player.all.each do |player|
      entry = player.entries.create! :year => 2010
      picks = Pick.all(:conditions => {:player_id => player.id})
      picks.each do |pick|
        pick.update_attributes!(:entry => entry, :player_id => nil)
      end
    end
  end

end
