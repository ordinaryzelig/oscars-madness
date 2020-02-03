task :import => :environment do
  Film.transaction do
    json = File.read("./nominations/#{Date.today.year}/nominations.json")
    ap Importer.(json)
    #raise ActiveRecord::Rollback
  end
end
